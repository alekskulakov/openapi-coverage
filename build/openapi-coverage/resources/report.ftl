<#ftl output_format="HTML">
<#global i18=messages>
<#global operationMap=data.flatOperations>
<#-- @ftlvariable ftlvariable name="data" type="com.github.viclovsky.swagger.coverage.model.SwaggerCoverageResults" -->
<#import "ui.ftl" as ui/>
<#import "summary.ftl" as summary />
<#import "generation.ftl" as generation />
<#import "operation.ftl" as operations />
<#import "condition.ftl" as condition />
<#import "tag.ftl" as tag />
<head>
    <meta charset="utf-8">
    <title>Swagger1 Coverage</title>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
          integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://kit.fontawesome.com/0b83173bdb.js" crossorigin="anonymous"></script>
    <style>
        .title {
            margin-top: 60px;
        }
        .progress {
            position: relative;
        }
        .progress span {
            position: absolute;
            display: block;
            width: 100%;
            color: black;
        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
    <div class="container">
        <div class="collapse navbar-collapse" id="navbarCollapse">
            <a class="navbar-brand" href="#">${data.info.getTitle()!} ${data.info.getVersion()!}</a>
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#summary-section">${i18["menu.summary"]}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#details-section">${i18["menu.operations"]}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#tag-section">${i18["menu.tags"]}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#condition-section">${i18["menu.condition"]}</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#system-section">${i18["menu.generation"]}</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<main role="main" class="container">
    <div class="container">
        <section id="summary-section">
            <div class="row">
                <div class="col-12">
                    <h2 class="title" id="summary">${i18["menu.summary"]}</h2>
                </div>
            </div>
            <@summary.operations operationCoveredMap=data.coverageOperationMap />
            <@summary.calls data=data />
            <@summary.tags tagsDetail=data.tagCoverageMap tagCounter=data.tagCounter />
            <@summary.conditions counter=data.conditionCounter />
        </section>
        <section id="details-section">
            <div class="row">
                <div class="col-12">
                    <h2 class="title" id="details">${i18["menu.operations"]}</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <ul class="nav nav-pills nav-fill" id="detail-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="condition-tab" data-toggle="tab" href="#condition" role="tab"
                               aria-controls="condition" aria-selected="true">
                                ${i18["operations.all"]}: ${data.operations?size}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="full-tab" data-toggle="tab" href="#full" role="tab"
                               aria-controls="full" aria-selected="true">
                                ${i18["operations.full"]}: ${data.coverageOperationMap.full?size}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="party-tab" data-toggle="tab" href="#party" role="tab"
                               aria-controls="party" aria-selected="true">
                                ${i18["operations.partial"]}: ${data.coverageOperationMap.party?size}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="empty-tab" data-toggle="tab" href="#empty" role="tab"
                               aria-controls="empty" aria-selected="true">
                                ${i18["operations.empty"]}: ${data.coverageOperationMap.empty?size}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="zero-tab" data-toggle="tab" href="#zero" role="tab"
                               aria-controls="zero" aria-selected="true">
                                ${i18["operations.no_call"]}: ${data.zeroCall?size}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="missed-tab" data-toggle="tab" href="#missed" role="tab"
                               aria-controls="missed" aria-selected="false">
                                ${i18["operations.missed"]}: ${data.missed?size}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="deprecated-tab" data-toggle="tab" href="#deprecated" role="tab"
                               aria-controls="deprecated" aria-selected="false">
                                ${i18["operations.deprecated"]}: ${data.deprecated?size}
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <br/>
            <div class="row">
                <div class="col-12">
                    <div class="tab-content" id="details-content">
                        <div class="tab-pane fade show active" id="condition" role="tabpanel" aria-labelledby="condition-tab">
                            <@condition.list
                                coverage=data.coverageOperationMap.full + data.coverageOperationMap.party + data.coverageOperationMap.empty
                                prefix="condition"/>
                        </div>
                        <div class="tab-pane fade" id="full" role="tabpanel" aria-labelledby="full-tab">
                            <@condition.list coverage=data.coverageOperationMap.full prefix="full"/>
                        </div>
                        <div class="tab-pane fade" id="party" role="tabpanel" aria-labelledby="party-tab">
                            <@condition.list coverage=data.coverageOperationMap.party prefix="party"/>
                        </div>
                        <div class="tab-pane fade" id="empty" role="tabpanel" aria-labelledby="empty-tab">
                            <@condition.list coverage=data.coverageOperationMap.empty prefix="empty"/>
                        </div>
                        <div class="tab-pane fade" id="zero" role="tabpanel" aria-labelledby="zero-tab">
                            <@condition.list coverage=data.zeroCall prefix="zero"/>
                        </div>
                        <div class="tab-pane fade" id="missed" role="tabpanel" aria-labelledby="missed-tab">
                            <@operations.list coverage=data.missed prefix="missed"/>
                        </div>
                        <div class="tab-pane fade" id="deprecated" role="tabpanel" aria-labelledby="deprecated-tab">
                            <@operations.list coverage=data.deprecated prefix="deprecated"/>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</main>
</body>
