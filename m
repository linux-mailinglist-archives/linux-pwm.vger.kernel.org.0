Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7917633BD5
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Nov 2022 12:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiKVLxr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Nov 2022 06:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiKVLxf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Nov 2022 06:53:35 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2136.outbound.protection.outlook.com [40.107.113.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BEC140B0;
        Tue, 22 Nov 2022 03:53:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eM5PvyDUdWQSSFBwNxqpzIuOqVSJZB09KFYNNX+DKmd+APXMnBvgCFsXa4sZSVZTHbM9S414TYhzomQtJk452d0OmCDOodJak8VGT5qycjc0n4pMpR+LKOQWiruhzA55HUw5XcJMdXig5msU/1kcyQj7C2+adywW5HH3KXrO2Dz4tn1TLa1qXF4gqs72l0YJsOdO/ow3wVPJH0jlGqinP9QCQu8K7cV6wMIYGHj1K4RySVcMuW44lUHp0Ag5X3dmDITQ0jnO8M5dzQDvHefi7fvotE0DbJEf0ftddRPSh5fyOZCVbIFM0CY5q2Ykf/EI9//32LJv/L79cZuf2tWCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l29t4EmOJzbNwG4wLHFFQwrur0xiEpLr3uhXtaSeEfQ=;
 b=OsiqiVPVKiqeF1irkvo1pL8pD8+QObF4Vw9wrjRzZZ0N1nODzSJ50oUdNeq+7T4ZzVl24yRo0w3R9+443moy70945q3x2ozmTZ2Y9QLKJBndKHpuz1wXtNabFnJcow8czlxJ/rvTBKcbq2yjwnJ1q/qYn3wSoAV3R4zM5M+PM3B5mAFGGH2VCY0Jv/TO0NoJ2s/LXiHIm+JCYzYeGM+jdiq72w+pBy49mK2usS1V6LitWSUm2kZW6VMnUmwQbRKc3nNyiD0PpYb9YaE72Io8QmUYFyi/ZKsY+lev1lfWNwzecgocGVY9cfjxpqXyQlxYLxwpErcrIszRqOr0cUu54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l29t4EmOJzbNwG4wLHFFQwrur0xiEpLr3uhXtaSeEfQ=;
 b=kJa/yEiWuCouTsemd2WKcwfryHql9vzLNsc6bwXfE+SKZBdk/XCoEmSRNtoqj/Pa2XxYq6x0v15vY0Q17nkZarRDTQG1GDMwYBhhKMXP3beGglY482ekZEd1J/Z8jOZ8YQuzC8HeR6h2e6ekRyfZtFS4bwOwDQo14lpkN+i2q5Q=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB9643.jpnprd01.prod.outlook.com (2603:1096:400:197::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 11:53:32 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2cfb:38d2:d52e:c8a3%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 11:53:32 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/5] dt-bindings: pwm: Add RZ/V2M PWM binding
Thread-Topic: [PATCH 2/5] dt-bindings: pwm: Add RZ/V2M PWM binding
Thread-Index: AQHY+1AJzP8tfGCBWUq0Wpj/5XpqF65K2YWAgAABoNA=
Date:   Tue, 22 Nov 2022 11:53:31 +0000
Message-ID: <OS0PR01MB592297BC4FBF2E8CFCAE5850860D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221118131641.469238-1-biju.das.jz@bp.renesas.com>
 <20221118131641.469238-3-biju.das.jz@bp.renesas.com>
 <fbc13bdd-68f7-cc78-57a0-4efe62431cc4@linaro.org>
In-Reply-To: <fbc13bdd-68f7-cc78-57a0-4efe62431cc4@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB9643:EE_
x-ms-office365-filtering-correlation-id: 3e5dfd22-73de-474b-b0e9-08dacc802da3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GoBmoVHML1hl9HLwju3lr2yu7yJpQuDB+ZYkZbNT1wqPkvqXQ0bjnx3iLhLQ9yOTTB///VuVwiOlGHxCSraVHgN/I/2pMEMLAHdLu0bu1LEVfswVh/qgSUa+tVEWwmu1miMMxfdeunqr1MfdyOYVx6MmvfzsFQ1fLaECHRUDIT1ai5MmeN4wFAzFoaGCt/KQs+fprxLVi/QJ1xq+Bl3E+/9ITgcqO3zGo1WrzZiTULM++vMqVdWjdyEF9aMAn3I8d3Fpr4hBsNi3n2P4CmC2+sfD0Lt2fBi1jKN6kmDWFD7dNLKx2xNeS5Xvw93fn0dOLKsEKbhcAwhLS6yVh58cvO4mV7WMVhZyDeTYpVKscpDz/ExoVvKkNYFK62uzzY3fQ5ftSiIIgVKYN50lcgYAoWTii08Uhki9XAvi7BH7OmH2jAR8q5v8TlW0Wv2MuczfxP2kF/ZfIsu494I/JrU7FibK5fbrc/JUXxB9DOUWWvNMNQItnIrwTUVz6paMEZjx7QBdunVKSuHMCFHMN3yPInVoWl08n8fxEkRcjlKVjYknXVfWcNftncGwsIdEPObNSTxEo3j3zSBGbaKumsqWr7qIE3cszagPAbNoj6iQdVM+1u/xaNnJZtbrS2vz4hGOsfmFz9GBYpdZfsWLA91VM7DceMXFM8I9ZJGddARfDB+p0KX5tzAhAz1F2SHic4nRqqR0ht9ES725M9bxpflGyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(451199015)(54906003)(38070700005)(86362001)(122000001)(33656002)(38100700002)(26005)(52536014)(4744005)(83380400001)(110136005)(186003)(9686003)(2906002)(7696005)(5660300002)(478600001)(8936002)(71200400001)(55016003)(64756008)(66946007)(66556008)(6506007)(76116006)(41300700001)(66446008)(66476007)(316002)(4326008)(8676002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXM0enNTQlVYRUZzNnVzLzhlRWZzU1kwM3ovZXhVS3FkbXBNTFV4SGRNeFRy?=
 =?utf-8?B?cUZJSGMxVzY4TWE1ZWFpWjZHZmFUWmJpUjBucmx3NzAyZU5EUlZPajZZMmQ3?=
 =?utf-8?B?VE8wTjNWYkt3WjNSZGdxRGpkKzBhNFdEbUkyM2FTRVkxZjV1ZXRuanRxenhT?=
 =?utf-8?B?Z0hMSUx5L0F0S3orbjJuVmNuYWJZeTlpSU9HSUlQNE1XU2E2YVFXRXQ1alBW?=
 =?utf-8?B?WnhiT1JLd2prc3haY1pEZHRhampxVHRRZm1RbktHZnNXMGFWZ3BOSVV5OEln?=
 =?utf-8?B?emNPM29heVdPY3lPZWdPNVVyYkxtNWtaeHNSWWF5V1dkbVpvSWRIKzByNlpK?=
 =?utf-8?B?TnlnRURCYzU3TWU4dUd3clEzSGMxaTNYRmptbnJZVmxKN2NucGdWZUxqQVNs?=
 =?utf-8?B?Z1ZpSlU3ajVRYjlvamVHTXhscllyeXpiRmxWeVJzMklrbXFuZGxIUmpmRHkx?=
 =?utf-8?B?eTU4U1NmaFYzVXFLbk5CeDRyT0EwSzB2RU5kemhjdVFVM09WNW02dkNhWDZH?=
 =?utf-8?B?elVSSEZCanhoRlUvdXRzSVhreXhTcVVhaEd4NDF1NUVURkMxaFcyWS9KU0ZM?=
 =?utf-8?B?NmR5bTJCSFlDTVp6TEEwNGRDaWFoT3R4VkdCSWU4bWhoYkJoeWRYUDF5V2lO?=
 =?utf-8?B?bE1RZUx6RVMzNGxMb1g5dDhBMFdsWURqdkhiOFpUU1ExdzVsNVhacHFUNGdr?=
 =?utf-8?B?ajhwQ3hUVWdjVlUxTWZhQUE3MENRVlV1bVRnUjJKWXdoRTY0MEdyMC93U2JU?=
 =?utf-8?B?RCtML1Rscm1YdUU0V2ZOZ0Z6S0pvZ0xNR3duWFhzajJFSnVqQTBIQ0I4U3Vm?=
 =?utf-8?B?Zm4xTkZRVkdBdFJaR2F2ZlhwUzZobStJRjZaNzdOek13R3hSY1dBRzlnODdj?=
 =?utf-8?B?MWFuZTZURE5vMys5Y2xCYmg5Y3BubkRSZzV6bGI4YWdvTDgzMTV4VDJleEFw?=
 =?utf-8?B?ZlBFV1U3R21wWEJPWGtqT0xLNlF4L1RYd2VteE5xYlY1QVpHTzg5YmpTcEIr?=
 =?utf-8?B?MXNYWWtINFAvT2QwcU1YYVBDTTRteG9zeFk5Zm1kbDFRcS9qdFZSZS9pVStI?=
 =?utf-8?B?TzdaOXBPQkRqVWFMSWh2WlR6YnlHOWNvenRhSllZdGpBbDFCUFZxZmhaOGJJ?=
 =?utf-8?B?eXZISjRIbzdCS0pzb2d5K1dhTFVqd3VvZXBnSzVMVW8wYitzQ0VyK2pobGVp?=
 =?utf-8?B?bzlzVTRzSE94aGk5dDdEekJYOFI5YWdYbU5HQlZYV0FqNTFVL1dtdHcxYWRJ?=
 =?utf-8?B?aS9keERNRkZ1cGkzaUo2bE9wWFZhWjhOM0EzTnl6V3RLYVFreE14Q0phMG9N?=
 =?utf-8?B?bE9iY0ZNaFV2VnF6cmlsdWpxUWhjRUo5U2ZlNXZhb0JpVlpHcWZleGZ3ajdx?=
 =?utf-8?B?VkRKVVppZHhOMWdJdHNidUxkV2ZGQXY1bC9RZzZUUGZZT0F4SHIvMlVTQTMy?=
 =?utf-8?B?TUVqT0l0RmZKZTdiYUE5d0pyNFBXZE9ua1pVWGh3eVorWk0vL04vUGNqWS9N?=
 =?utf-8?B?WWZKSVI5Y0pOWVBJYnZnRzNncHIzM2Y4bTFmOXpkbkg1SUNTYXVFUjc5VHNG?=
 =?utf-8?B?M3Bmek9NNnVnYnMvVlVyK2xaWkhGdmdOK244bGk4ZFJUVVp5MC9jQzA1VUNO?=
 =?utf-8?B?UVNsNkpNNFlGZVR5azJFd1RMc2tpc0c0K3lQMUFwN1RmUXFENERLSlFwS1Rz?=
 =?utf-8?B?N3JjMkZITENiNS9qRWZnVkRrZysxMFBpTnUvaWhzazIyaTYvd1BSanB2SjE0?=
 =?utf-8?B?VG5JZEdOOVF6ZHlFSWxtbWpsZi9MVmJpeGF5OE9zUElaVWZFWFN5cGFsd3FI?=
 =?utf-8?B?aFMzODZ1aVltaHk2QURyQVZQV29XYXREMGhnRk04ajR0ZlBqQzc0bGRtem9i?=
 =?utf-8?B?MzB3QWZ4MjZ3dzBUZWhhYmFmdGhmaVZqQ2tJSXp2V2NuMXB0V3pwTXRMUE1K?=
 =?utf-8?B?VHU2aU9hZEd6TXhoOFFyTnU4eW1pRnA2bXZzT2hzeDJvWFlPSVJNRVRlK20z?=
 =?utf-8?B?RjZlbS9RYnRyVk51cjlicndTN1V5WVlhSGJXeU05bVp3SXMwWGFhZVFkakZp?=
 =?utf-8?B?dmpNa0xCZDB2Z3Y2QzJzRHA1SlZJRndwTDlZWUFNSXB1eWJTR1dNMHdHSEJZ?=
 =?utf-8?B?bEorT0U3SXUrdDNCeGZpR0lIdm1NbVFSQUV3UExJcGNsT2E5cCtFbVM5bmJ5?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e5dfd22-73de-474b-b0e9-08dacc802da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2022 11:53:31.9616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N6mM1PfErCjoXj3J/PTLF6U1i4HKxvhWLxZrb46Af07EngzncIDbmVA5llPhtOHDM4OCTPR90OS/aD9AUxLXFkO7naHyKXG6vzkKBWesK7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9643
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KdGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAyLzVdIGR0LWJpbmRpbmdzOiBwd206IEFkZCBSWi9WMk0gUFdN
IGJpbmRpbmcNCj4gDQo+IE9uIDE4LzExLzIwMjIgMTQ6MTYsIEJpanUgRGFzIHdyb3RlOg0KPiA+
IEFkZCBkZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgdGhlIFJaL1Yye00sIE1BfSBQV00gVGltZXIg
KFBXTSkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAu
cmVuZXNhcy5jb20+DQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guIFRoZXJlIGlzIHNv
bWV0aGluZyB0byBkaXNjdXNzL2ltcHJvdmUuDQo+IA0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAt
IGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gaW50ZXJydXB0cw0KPiA+ICsgIC0g
Y2xvY2tzDQo+ID4gKyAgLSBjbG9jay1uYW1lcw0KPiA+ICsgIC0gcG93ZXItZG9tYWlucw0KPiA+
ICsNCj4gPiAraWY6DQo+ID4gKyAgcHJvcGVydGllczoNCj4gPiArICAgIGNvbXBhdGlibGU6DQo+
ID4gKyAgICAgIGNvbnRhaW5zOg0KPiA+ICsgICAgICAgIGVudW06DQo+ID4gKyAgICAgICAgICAt
IHJlbmVzYXMscjlhMDlnMDU1LXB3bQ0KPiA+ICt0aGVuOg0KPiA+ICsgIHJlcXVpcmVkOg0KPiA+
ICsgICAgLSByZXNldHMNCj4gPiArDQo+ID4gK2FsbE9mOg0KPiA+ICsgIC0gJHJlZjogcHdtLnlh
bWwjDQo+IA0KPiBQdXQgdGhlIGlmIHVuZGVyIGFsbE9mOg0KPiANCj4gYWxsT2Y6DQo+ICAtICRy
ZWYuLi4NCj4gIC0gaWY6DQo+ICAgICAgdGhlbjoNCj4gDQo+IFRoaXMgYWxsb3dzIGVhc2llciBn
cm93dGguDQoNCk9LIHdpbGwgc2VuZCB2MiwgYWxvbmcgd2l0aCBmZWVkYmFjayBmb3IgZHJpdmVy
IHBhdGNoZXMgaWYgYW55Lg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gDQo+IFdpdGggYWJvdmU6DQo+
IA0KPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3Nr
aUBsaW5hcm8ub3JnPg0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==
