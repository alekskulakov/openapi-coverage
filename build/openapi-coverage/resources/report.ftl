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
<body>
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
                            <a class="nav-link active" id="condition-tab" data-toggle="tab" role="tab"
                               aria-controls="condition" aria-selected="true">
                                ${i18["operations.all"]}: ${data.operations?size}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="full-tab" data-toggle="tab" role="tab"
                               aria-controls="full" aria-selected="true">
                                ${i18["operations.full"]}: ${data.coverageOperationMap.full?size}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="party-tab" data-toggle="tab" role="tab"
                               aria-controls="party" aria-selected="true">
                                ${i18["operations.partial"]}: ${data.coverageOperationMap.party?size}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="empty-tab" data-toggle="tab" role="tab"
                               aria-controls="empty" aria-selected="true">
                                ${i18["operations.empty"]}: ${data.coverageOperationMap.empty?size}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="zero-tab" data-toggle="tab" role="tab"
                               aria-controls="zero" aria-selected="true">
                                ${i18["operations.no_call"]}: ${data.zeroCall?size}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="missed-tab" data-toggle="tab" role="tab"
                               aria-controls="missed" aria-selected="false">
                                ${i18["operations.missed"]}: ${data.missed?size}
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="deprecated-tab" data-toggle="tab" role="tab"
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
                    </div>
                </div>
            </div>
        </section>
    </div>
</main>
</body>
