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
                    <ul role="tablist">
                        <li>
                            ${i18["operations.all"]}: ${data.operations?size}
                        </li>
                        <li>
                            ${i18["operations.full"]}: ${data.coverageOperationMap.full?size}
                        </li>
                        <li>
                            ${i18["operations.partial"]}: ${data.coverageOperationMap.party?size}
                        </li>
                        <li>
                            ${i18["operations.empty"]}: ${data.coverageOperationMap.empty?size}
                        </li>
                        <li>
                            ${i18["operations.no_call"]}: ${data.zeroCall?size}
                        </li>
                        <li>
                            ${i18["operations.missed"]}: ${data.missed?size}
                        </li>
                        <li>
                            ${i18["operations.deprecated"]}: ${data.deprecated?size}
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
