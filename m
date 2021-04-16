Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6072D361C08
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Apr 2021 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhDPIpW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Apr 2021 04:45:22 -0400
Received: from mail-eopbgr1310114.outbound.protection.outlook.com ([40.107.131.114]:12704
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240294AbhDPIpV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Apr 2021 04:45:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHtzUUlmkaFezLAm9A4rC7J+6qX/DIaIF0S526J9bT0fsFGHFxmdiTahOWFA+2t3498d6nNi9KSQQJq/vGB/Z/moRoSV3ns09bYG2mhxdCyjvWUNtGRQkNDZ/YJrEiqs3eDcgH5EZ2i2PBHUccy0eDYjFl30uFXbBYaxaWlAtlzvxDA7UgwPqLbyGnJsezUEsV0oBELmMZzcgZUDUaFjVVUC36ZaoFJBd+GBW/gNYXJU/THT0N/gSCCRokJ45m/yvqB71mL0xeFvlDhtLR0qp8q0GzxvNdHAzI3c7Lv4tqXGb8CyzdDV2FELoJeKBIqOxD/nzLLCaTx9UpjmyrN+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pitRifE1kkdOTo41/jviJfOw+5mpJmgQ9rR3MbN6PI0=;
 b=oc/aVsk8EIatvQ+JRAO46FyL9jseHRPqci/wu3Ra8H6o3WoMbWUSeTDwyrwjc0QnXJ/Bha41eSSgSBh0Fq6tNhX+kjTnMJVijgOgHOyxxfYm3XEzysOLMXw787eq0mONVoAoSDBwzHjRnWXQs63e41Jka4GVuQaqVbmOZwEDk+bacV9ypE+99+DZG04YR5v9No/CNk+Egrkv+7FelFzEzf0VwHooAOZz6EQpSd9FMvzKUqSNMS5bdlJlEqhKdOegu0W/5MjoStTVaYRIOqzt4Qiu0GAxCi07cqxgRSYEyL9OQzOABnl2gZfS47Va1iN2A+8hPeItdp7RM22NRxocpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pitRifE1kkdOTo41/jviJfOw+5mpJmgQ9rR3MbN6PI0=;
 b=SUM7jpIHRhSL3pxgnxoMp3Rw4WVoaBOatJDl3ypmjaBMPQziVr4TAD6xZ608wkicedb2MRlc5BIpYlg+QfWkis6ADWkY2Ru+Mo1zUhIkDNaIKkDoOG5WpAxvC2fkN1y76F0np/XxvTIZO4Sz0DKtTkEmfcKW5zHDX7MGzGJc+Pi43vcMxuA2TXBwnw55R4KB5E0SsFiH9fhrV2Eawj+TpwMq1vuFXaD8hBZAn2BKPxgw2DCfjdnsy4C4VG2Z2IiP1YqtXsk4cuE8fgIaF1WiwKzp9LdBQQSMr9bXGb2mZ5yctTlMrV7VHVZTK9ZxMmUD/JPs/3FhGO4a+BwpiB8lxA==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB3041.apcprd06.prod.outlook.com (2603:1096:203:84::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 08:44:53 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::4d49:12fe:2d9a:b1bd]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::4d49:12fe:2d9a:b1bd%3]) with mapi id 15.20.4042.016; Fri, 16 Apr 2021
 08:44:53 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v2 1/2] dt-bindings: Add bindings for aspeed pwm-tach and pwm.
Thread-Topic: [v2 1/2] dt-bindings: Add bindings for aspeed pwm-tach and pwm.
Thread-Index: AQHXMRveymfOqXW0b0q4pkWKQfA6vaq0lT+AgADh7ICAADISAIABtDAA
Date:   Fri, 16 Apr 2021 08:44:52 +0000
Message-ID: <C487E9FF-3DAD-4322-996A-8164861572CF@aspeedtech.com>
References: <20210414104939.1093-1-billy_tsai@aspeedtech.com>
 <20210414104939.1093-2-billy_tsai@aspeedtech.com>
 <20210414221553.GA56046@robh.at.kernel.org>
 <B9287FE7-5EF5-40B3-BCB3-08DA11D6CDD7@aspeedtech.com>
 <CAL_JsqLuswcRqQ-JQ9qgWQEhykPWCTsnVFLxCEPV6BbF86vWOw@mail.gmail.com>
In-Reply-To: <CAL_JsqLuswcRqQ-JQ9qgWQEhykPWCTsnVFLxCEPV6BbF86vWOw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd3e2069-47c2-440d-0e4d-08d900b3e77d
x-ms-traffictypediagnostic: HK0PR06MB3041:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB304153EB1DA52775892620128B4C9@HK0PR06MB3041.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/9GTXa4sUZgqT5scFE4K5kcA6MGRnjhoHLze79pqYefakjyqAo/PY9LwcGzfU9EgFyCm9GtfL79Dnath27V26FYxpOndaS4tFlyHSpYaMltkFHrIJhoPybbDIhfGwXWegpPoE6KZt2ISAQf5prPQUP7gqgZ1ROmvhPLbtDVBvCRmy9vivRO0IpfUZmChpaLmK0UZ6wPK5L6wIuiDPS1JJcxtTmmfUa/6RfomwDOo1usgtsenF8gJm6VQ1v0NxxasVKN3fpBGmHuDxb+5aMoTEdyqBhMi/Tesb+grcUM6OUNcos9C49BS64uM9vYTT4wqY97Wpg9I8WJZlmAqvmSWcn8Cd4VGafDoHVAiBJPfrSnJ+MNWIQUml7oaMk4Q7LLTMvdX/AGV6qRpbHcxqwEVDa/Hr7vHbp57UodDB37ZmOypnhzO8gjBiQydk6v4TZBCr32NWSIuZCe5WPi5GU1xSwM8XE4/rjy+N5jLUyL6sZ7mavkMbz6//umhPuDzd2+H3x7ELtzeD6vwFFoxTPN6n4FVoi+mIOiDmyTxd1GLePd1ZqCukzslO446c/dLz/iG3FUEzrHPIs2+ECSjFrgSMO14VSFU1wvKMZhdzNccOVSZSwiCf60xkjop4u9dYezybLDb+FSKpJ3yZxEDgtQJ7X9u3k+uwWxtQ5P/c6wktrKOE2oK5A9wOHFnKpSbuyihRytls+OoPwm5BN69grgwYPMmXs0p9XEASqUsbIaMh4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(39840400004)(396003)(107886003)(5660300002)(26005)(54906003)(186003)(6512007)(6486002)(8676002)(316002)(86362001)(33656002)(478600001)(66476007)(966005)(2616005)(83380400001)(6506007)(66556008)(38100700002)(122000001)(36756003)(2906002)(7416002)(4326008)(71200400001)(76116006)(55236004)(64756008)(8936002)(66446008)(6916009)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cDF0VHBaL3JEaHN6SDZNY09WbHk5aHhKSnhKT0tsZTNsZm8zekVITXlQMTBG?=
 =?utf-8?B?Sk9EK0lrN3Q5VGgzMHBtd0lZNWIrNXdWM3htMG1FMFNORExnNktDOW5iQ0I3?=
 =?utf-8?B?a2xZNDRzbGVGc1lqc1NNTjRWWkN5OGNMRG0wRmc5UVVSSGUvM3RhN0puK2tF?=
 =?utf-8?B?cDRjcDg1NVRyZkp2NnNlS1FJcUZ3TVNMWjl6K3NpckgxT25NR3VSUnJQZzZK?=
 =?utf-8?B?M2d5YWQvVnpmZjIrYUhPdWhVaGpDaTVFV3VUeElqUnhudHVBaVRUb0RYNVM0?=
 =?utf-8?B?dzJBdU4xWjk2SmFQQlBTTTZoOGoyUko3YXRmOHJZa2lmaGRGdjd3aTZkVzVZ?=
 =?utf-8?B?Qk8rVmJyc0tMN1BTWG9uODBEK2xZaHNlTitQdnN0SG16ZU1VREdWYW54RFZF?=
 =?utf-8?B?bEZtQm1WbHJ6c2tQcmlIbTFEdS9PSmJjdVFpREJuWEN6aXh3R1NGSGYxM1B2?=
 =?utf-8?B?dVNIOEh3TmJnZkZ4TnhXaEJvSG5od2RWVkZrOFltYk9uRjRTNzUyWXRVakxa?=
 =?utf-8?B?VE1zeXZrUGdHNFp1eFBHVkRwK1g1T2JXZTROeXpGSTAyYUJlS3dla3NTdytz?=
 =?utf-8?B?KzlWckliemZkdE1yem5LOXJGQXVxeWhvODhVYXF2UG1ray9TY0trM3dsb0ZS?=
 =?utf-8?B?TXNCS2NXSmJxRnBlSTIvYWlGRXcrUmRIeUhoY0R1NCtQdzhnMkg5TDFQSzBD?=
 =?utf-8?B?cFdjU0pvd3dFZU1zRGo4NEM3M3dTdVUvWnFoZncydVlzd0FDMmRINWtmL1lx?=
 =?utf-8?B?MldHRCtvaHo3OW9HY0tWM3JURGVqN1ZhczZRc0tTcGpQUnRRQUNBRXZXdFBz?=
 =?utf-8?B?cDEzanpYNFRUdDdLempKZnJoWlAyZ0N1OWNrKzVKb1pKWHo1ZWlLajN3amNX?=
 =?utf-8?B?UjJjazd4ZjhUekl2REtUTFRzOXUwSkxxelUwQ2tXUm50ZHgxZE9tSUFhS0RC?=
 =?utf-8?B?MWtRYzJGV0IyS01KSTdDZ1kwU3I3bkdVR3FPdDNuTGxtWU05d3FKb0YvT240?=
 =?utf-8?B?cUYvNGVZV3pCUi9SdlQwc1Y2Z0JveFRmZDhvQkRXaytlQng1OVhpWFpEcElI?=
 =?utf-8?B?Zlg5YWwrZ1VqYkJMZ2xmUGgwdVptRXRjZ29SYW9wSGFzbnJQNHRkTkJJdzhX?=
 =?utf-8?B?eGxuZm5ZeU0yZzhzL2dKR0hwQmF2ZUc4TDN6dXBLb1JXZmV4ZEc3Mm1CNE5J?=
 =?utf-8?B?YUova0ErMjNrT1JxWlVpcDVpVUtPKzZpTVIwbkVqMjBNb282RWRNTG43ajRJ?=
 =?utf-8?B?UlNyTExXeHB6aS9VUjFQWGNZUm51UE9jR1FTUDU4dDJKNWx0UTRXTm1GWjRs?=
 =?utf-8?B?ZHhSekhWTTRwZERRQWUyVE12RUFJa0VIR1oxeTl5aldJWDFTbkFRZld0VDc3?=
 =?utf-8?B?bnRqOWJ3eHE4N05vT1F2Vnd0a3FqZ0lFcnp5U2lNL2NvREMydStZMVRXc3c4?=
 =?utf-8?B?akY0V0R0QU0xbzJlQjJOaTRUVzc0dUJGZjZ4MldFK1M2azhqaFhwZ3NTTE9Q?=
 =?utf-8?B?QWlMbWhQQWcxVE9odjRobm1GS0o1Q2tiMktFVFhpZlRPNGNieXl2TytNb2RN?=
 =?utf-8?B?MjlWOFNGelNJaFpWa29WMHBIT3NidDJJamhEOFpTOEJINzBzTVcyaHkrRnBx?=
 =?utf-8?B?TXJxM3VPaDlQOEV3Z0NUM1crdlFSRHpoc09LRU9aZmZkMFpKT3VUSWVHR1U5?=
 =?utf-8?B?dndwc0RlRXpPZHg4SmEzd3U0a1BybmdkWEsvcWRPcy9rM0pwSjhtazAvVUZT?=
 =?utf-8?Q?lcX0yr1yBaqQdZBNym2I69YjL1jddU1Rg4xNtCM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61671B1BFD80E149B53305CDDA46D1B6@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3e2069-47c2-440d-0e4d-08d900b3e77d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 08:44:53.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n86KkzbuGzNw/5pIkoKFynta43sm5s490K9pA6Z/+Ek73ZZ7jxTXCLux4L8NfY9h8IWv6twsMObT5/RcC/xJe6iOw1Qhl4vqAhlTT+5Rz68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3041
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQpPbiAyMDIxLzQvMTUsIDEwOjQ0IFBNLFJvYiBIZXJyaW5nd3JvdGU6DQoNCiAgICA+T24gV2Vk
LCBBcHIgMTQsIDIwMjEgYXQgMTA6NDQgUE0gQmlsbHkgVHNhaSA8YmlsbHlfdHNhaUBhc3BlZWR0
ZWNoLmNvbT4gd3JvdGU6DQogICAgPj4NCiAgICA+PiBIaSBSb2IsDQogICAgPj4NCiAgICA+PiBP
biAyMDIxLzQvMTUsIDY6MTYgQU0sUm9iIEhlcnJpbmd3cm90ZToNCiAgICA+Pg0KICAgID4+ICAg
ICBPbiBXZWQsIEFwciAxNCwgMjAyMSBhdCAwNjo0OTozOFBNICswODAwLCBCaWxseSBUc2FpIHdy
b3RlOg0KICAgID4+ICAgICA+PiBUaGlzIHBhdGNoIGFkZHMgZGV2aWNlIGJpbmRpbmdzIGZvciBh
c3BlZWQgcHdtLXRhY2ggZGV2aWNlIHdoaWNoIGlzIGENCiAgICA+PiAgICAgPj4gbXVsdGktZnVu
Y3Rpb24gZGV2aWNlIGluY2x1ZGUgcHduIGFuZCB0YWNoIGZ1bmN0aW9uIGFuZCBwd20gZGV2aWNl
IHdoaWNoDQogICAgPj4gICAgID4+IHNob3VsZCBiZSB0aGUgc3ViLW5vZGUgb2YgcHdtLXRhY2gg
ZGV2aWNlLg0KICAgID4+ICAgICA+Pg0KICAgID4+ICAgICA+PiBTaWduZWQtb2ZmLWJ5OiBCaWxs
eSBUc2FpIDxiaWxseV90c2FpQGFzcGVlZHRlY2guY29tPg0KICAgID4+ICAgICA+PiBDaGFuZ2Ut
SWQ6IEkxOGQ5ZGVhMTRjM2EwNGUxYjdlMzhmZmVjZDQ5ZDQ1OTE3YjliNTQ1DQogICAgPj4gICAg
ID4NCiAgICA+PiAgICAgPkRyb3ANCiAgICA+PiAgICAgPg0KICAgID4+ICAgICA+PiAtLS0NCiAg
ICA+PiAgICAgPj4gIC4uLi9iaW5kaW5ncy9tZmQvYXNwZWVkLGFzdDI2MDAtcHdtLXRhY2gueWFt
bCB8IDYwICsrKysrKysrKysrKysrKysrKysNCiAgICA+PiAgICAgPj4gIC4uLi9iaW5kaW5ncy9w
d20vYXNwZWVkLGFzdDI2MDAtcHdtLnlhbWwgICAgICB8IDQ0ICsrKysrKysrKysrKysrDQogICAg
Pj4gICAgID4+ICAyIGZpbGVzIGNoYW5nZWQsIDEwNCBpbnNlcnRpb25zKCspDQogICAgPj4gICAg
ID4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21mZC9hc3BlZWQsYXN0MjYwMC1wd20tdGFjaC55YW1sDQogICAgPj4gICAgID4+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9hc3BlZWQs
YXN0MjYwMC1wd20ueWFtbA0KICAgID4+ICAgICA+Pg0KICAgID4+ICAgICA+PiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MjYwMC1w
d20tdGFjaC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3Bl
ZWQsYXN0MjYwMC1wd20tdGFjaC55YW1sDQogICAgPj4gICAgID4+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQogICAgPj4gICAgID4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZWFmOGJkZjhkNDRlDQogICAg
Pj4gICAgID4+IC0tLSAvZGV2L251bGwNCiAgICA+PiAgICAgPj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hc3BlZWQsYXN0MjYwMC1wd20tdGFjaC55YW1sDQog
ICAgPj4gICAgID4+IEBAIC0wLDAgKzEsNjAgQEANCiAgICA+PiAgICAgPj4gKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KICAgID4+ICAg
ICA+PiArIyBDb3B5cmlnaHQgKEMpIDIwMjEgQVNQRUVELCBJbmMuDQogICAgPj4gICAgID4+ICsl
WUFNTCAxLjINCiAgICA+PiAgICAgPj4gKy0tLQ0KICAgID4+ICAgICA+PiArJGlkOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9tZmQvYXNwZWVkLGFzdDI2MDAtcHdtLXRhY2gueWFtbCMN
CiAgICA+PiAgICAgPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVt
YXMvY29yZS55YW1sIw0KICAgID4+ICAgICA+PiArDQogICAgPj4gICAgID4+ICt0aXRsZTogUFdN
IFRhY2ggY29udHJvbGxlciBEZXZpY2UgVHJlZSBCaW5kaW5ncw0KICAgID4+ICAgICA+PiArDQog
ICAgPj4gICAgID4+ICtkZXNjcmlwdGlvbjogfA0KICAgID4+ICAgICA+PiArICBUaGUgUFdNIFRh
Y2ggY29udHJvbGxlciBpcyByZXByZXNlbnRlZCBhcyBhIG11bHRpLWZ1bmN0aW9uIGRldmljZSB3
aGljaA0KICAgID4+ICAgICA+PiArICBpbmNsdWRlczoNCiAgICA+PiAgICAgPj4gKyAgICBQV00N
CiAgICA+PiAgICAgPj4gKyAgICBUYWNoDQogICAgPj4NCiAgICA+PiAgICAgPiBCdXQgaXMgaXQg
cmVhbGx5PyBBIFBXTSBhbmQgdGFjaCBzb3VuZHMgbGlrZSBhIGZhbiBjb250cm9sbGVyLiBMb29r
IGF0DQogICAgPj4NCiAgICA+PiBPdXIgUFdNIGlzIG5vdCBvbmx5IGZvciBmYW5zIGJ1dCBhbHNv
IHVzZWQgZm9yIHRoZSBtb3RvciwgbGVkLCBidXp6ZXIsIGFuZCBzbyBvbi4NCiAgICA+PiBTbyBJ
IHdhbnQgdG8gc3BsaXQgdGhlIGZ1bmN0aW9uIGludG8gdHdvIGRldmljZXMgd2l0aCBhIG11bHRp
LWZ1bmN0aW9uIGRldmljZS4NCiAgICA+PiBPbmUgZm9yIFBXTSBvdXRwdXQgYW5kIG9uZSBmb3Ig
dGFjaCBtb25pdG9yLg0KICAgID4+DQogICAgPj4gICAgID4gb3RoZXIgZXhpc3RpbmcgUFdNK3Rh
Y2ggYmluZGluZ3Mgd2UgaGF2ZSBmb3IgZmFucy4NCiAgICA+Pg0KICAgID4+IEkgZGlkbid0IHNl
ZSB0aGUgUFdNK3RhY2ggYmluZGluZ3MgY2FuIHlvdSBnaXZlIHNvbWUgZXhhbXBsZSBmb3IgbWUs
IHRoYW5rcy4NCiAgICA+DQogICAgPkxldCBtZSBncmVwICd0YWNoJyBmb3IgeW91Og0KICAgID4N
CiAgICA+RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FzcGVlZC1wd20t
dGFjaG8udHh0DQogICAgPkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9u
cGNtNzUwLXB3bS1mYW4udHh0DQogICAgPg0KICAgID5IZXksIGxvb2sgYXQgdGhhdCwgdGhlcmUn
cyBhbHJlYWR5IG9uZSBmb3IgQVNwZWVkLiBTbyB0aGUgcXVlc3Rpb24gaXMNCiAgICA+aG93IGlz
IHRoZSBuZXdlciBoL3cgZGlmZmVyZW50Pw0KICAgID4+DQogICAgPj4gICAgID4+ICsNCiAgICA+
PiAgICAgPj4gK21haW50YWluZXJzOg0KICAgID4+ICAgICA+PiArICAtIEJpbGx5IFRzYWkgPGJp
bGx5X3RzYWlAYXNwZWVkdGVjaC5jb20+DQogICAgPj4gICAgID4+ICsNCiAgICA+PiAgICAgPj4g
K3Byb3BlcnRpZXM6DQogICAgPj4gICAgID4+ICsgIGNvbXBhdGlibGU6DQogICAgPj4gICAgID4+
ICsgICAgaXRlbXM6DQogICAgPj4gICAgID4+ICsgICAgICAtIGVudW06DQogICAgPj4gICAgID4+
ICsgICAgICAgICAgLSBhc3BlZWQsYXN0MjYwMC1wd20tdGFjaA0KICAgID4+ICAgICA+PiArICAg
ICAgLSBjb25zdDogc3lzY29uDQogICAgPj4gICAgID4+ICsgICAgICAtIGNvbnN0OiBzaW1wbGUt
bWZkDQogICAgPj4gICAgID4+ICsgIHJlZzoNCiAgICA+PiAgICAgPj4gKyAgICBtYXhJdGVtczog
MQ0KICAgID4+ICAgICA+PiArICAiI2FkZHJlc3MtY2VsbHMiOg0KICAgID4+ICAgICA+PiArICAg
IGNvbnN0OiAxDQogICAgPj4gICAgID4+ICsgICIjc2l6ZS1jZWxscyI6DQogICAgPj4gICAgID4+
ICsgICAgY29uc3Q6IDENCiAgICA+PiAgICAgPj4gKw0KICAgID4+ICAgICA+PiArcmVxdWlyZWQ6
DQogICAgPj4gICAgID4+ICsgIC0gY29tcGF0aWJsZQ0KICAgID4+ICAgICA+PiArICAtIHJlZw0K
ICAgID4+ICAgICA+PiArICAtICIjYWRkcmVzcy1jZWxscyINCiAgICA+PiAgICAgPj4gKyAgLSAi
I3NpemUtY2VsbHMiDQogICAgPj4gICAgID4+ICsNCiAgICA+PiAgICAgPj4gK2FkZGl0aW9uYWxQ
cm9wZXJ0aWVzOg0KICAgID4+ICAgICA+PiArICB0eXBlOiBvYmplY3QNCiAgICA+Pg0KICAgID4+
ICAgICA+IEFzIHlvdSBrbm93IHRoZSAyIG5vZGUgbmFtZXMsIHRoZXkgc2hvdWxkIGJlIGRvY3Vt
ZW50ZWQuIEhvd2V2ZXIsIHNlZQ0KICAgID4+ICAgICA+IGJlbG93Lg0KICAgID4+DQogICAgPj4g
ICAgID4+ICsNCiAgICA+PiAgICAgPj4gK2V4YW1wbGVzOg0KICAgID4+ICAgICA+PiArICAtIHwN
CiAgICA+PiAgICAgPj4gKyAgICBwd21fdGFjaDogcHdtX3RhY2hAMWU2MTAwMDAgew0KICAgID4+
ICAgICA+PiArICAgICAgY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjYwMC1wd20tdGFjaCIsICJz
eXNjb24iLCAic2ltcGxlLW1mZCI7DQogICAgPj4gICAgID4+ICsgICAgICAjYWRkcmVzcy1jZWxs
cyA9IDwxPjsNCiAgICA+PiAgICAgPj4gKyAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0KICAgID4+
ICAgICA+PiArICAgICAgcmVnID0gPDB4MWU2MTAwMDAgMHgxMDA+Ow0KICAgID4+ICAgICA+PiAr
DQogICAgPj4gICAgID4+ICsgICAgICBwd206IHB3bUAwIHsNCiAgICA+PiAgICAgPj4gKyAgICAg
ICAgY29tcGF0aWJsZSA9ICJhc3BlZWQsYXN0MjYwMC1wd20iOw0KICAgID4+ICAgICA+PiArICAg
ICAgICAjcHdtLWNlbGxzID0gPDM+Ow0KICAgID4+ICAgICA+PiArICAgICAgICByZWcgPSA8MHgw
IDB4MTAwPjsNCiAgICA+PiAgICAgPj4gKyAgICAgIH07DQogICAgPj4gICAgID4+ICsNCiAgICA+
PiAgICAgPj4gKyAgICAgIHRhY2g6IHRhY2hAMSB7DQogICAgPj4gICAgID4+ICsgICAgICAgIGNv
bXBhdGlibGUgPSAiYXNwZWVkLGFzdDI2MDAtdGFjaCI7DQogICAgPj4gICAgID4+ICsgICAgICAg
IHJlZyA9IDwweDAgMHgxMDA+Ow0KICAgID4+DQogICAgPj4gICAgID4gWW91IGhhdmUgMiBub2Rl
cyBhdCB0aGUgc2FtZSBhZGRyZXNzLiBOb3QgdmFsaWQuDQogICAgPj4NCiAgICA+PiBPdXIgcHdt
IGFuZCB0YWNoIGlzIHVzZWQgdGhlIHNhbWUgYmFzZSBhZGRyZXNzIGFuZCB0aGUgb2Zmc2V0IGlz
IGxpa2UgYmVsb3c6DQogICAgPj4NCiAgICA+PiBQV00wIHVzZWQgMHgwIDB4NCwgVGFjaDAgdXNl
ZCAweDggMHhjDQogICAgPj4gUFdNMSB1c2VkIDB4MTAgMHgxNCwgVGFjaDEgdXNlZCAweDE4IDB4
MWMNCiAgICA+PiAuLi4NCiAgICA+Pg0KICAgID4+IEkgd2lsbCByZW1vdmUgdGhlIHJlZyBwcm9w
ZXJ0eSBmcm9tIHB3bSBhbmQgdGFjaCBub2RlIGFuZCByZW1vdmUgdGhlICIjYWRkcmVzcy1jZWxs
cyIgYW5kDQogICAgPj4gIiNzaXplLWNlbGxzIiBmcm9tIHRoZSBwYXJlbnQgbm9kZS4NCiAgICA+
DQogICAgPlRoYXQncyBub3QgcmVhbGx5IHRoZSBzb2x1dGlvbi4uLg0KICAgID4NCiAgICA+Pg0K
ICAgID4+ICAgICA+PiArICAgICAgfTsNCiAgICA+Pg0KICAgID4+ICAgICA+IFRoZXJlJ3Mgbm8g
cmVhbCBuZWVkIGZvciAyIGNoaWxkIG5vZGVzLiBUaGUgcGFyZW50IG5vZGUgY2FuIGJlIGEgUFdN
DQogICAgPj4gICAgID4gcHJvdmlkZXIuDQogICAgPj4NCiAgICA+PiBIb3dldmVyLCBJbiBvdXIg
dXNhZ2UsIHRoZSBwYXJlbnQgbm9kZSBpcyBhIG1mZCwgbm90IGEgc2ltcGxlIFBXTSBkZXZpY2Ug
b25seS4gSSBkb24ndCB3YW50IHRvDQogICAgPj4gY29tYmluZSB0aGUgZGlmZmVyZW50IGZ1bmN0
aW9ucyB3aXRoIHRoZSBvbmUgZGV2aWNlIG5vZGUuDQogICAgPg0KICAgID5Mb29rcyBsaWtlIGEg
c2luZ2xlIGgvdyBibG9jayB0byBtZS4gSWYgeW91IHdhbnQgdG8gZGl2aWRlIHRoYXQgdXANCiAg
ICA+aW50byBtdWx0aXBsZSBkcml2ZXJzLCB0aGVuIHRoYXQncyBhbiBPUyBwcm9ibGVtLiBBIHNp
bmdsZSBub2RlIGNhbiBiZQ0KICAgID5tdWx0aXBsZSBwcm92aWRlcnMuIEZvciBleGFtcGxlLCBv
biB0aGUgZXhpc3RpbmcgYXNwZWVkIGJpbmRpbmcsIGp1c3QNCiAgICA+YWRkICcjcHdtLWNlbGxz
JyB0byB0aGUgbm9kZSBpZiB5b3Ugd2FudCB0byBhbHNvIGV4cG9zZSBpdCBhcyBhIFBXTQ0KICAg
ID5wcm92aWRlci4NCiAgICA+DQogICAgPlJvYg0KDQpJIGRvbid0IHRoaW5rIHRoZSBwd20vdGFj
aCBzaG91bGQgYmUgYSBzaW5nbGUgaC93IGJsb2NrLiANClNlZSB0aGUga29udHJvbixzbDI4Y3Bs
ZC55YW1sOg0KaHdtb25AYiB7DQogICAgICAgIGNvbXBhdGlibGUgPSAia29udHJvbixzbDI4Y3Bs
ZC1mYW4iOw0KICAgICAgICByZWcgPSA8MHhiPjsNCn07DQoNCnB3bUBjIHsNCiAgICAgICAgY29t
cGF0aWJsZSA9ICJrb250cm9uLHNsMjhjcGxkLXB3bSI7DQogICAgICAgIHJlZyA9IDwweGM+Ow0K
ICAgICAgICAjcHdtLWNlbGxzID0gPDI+Ow0KfTsNClRoZXkgY2FuIGJlIHRoZSBkaWZmZXJlbnQg
ZnVuY3Rpb24gZnJvbSB0aGUgZHRzLg0KDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaHdtb24vYXNwZWVkLXB3bS10YWNoby50eHQNCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9od21vbi9ucGNtNzUwLXB3bS1mYW4udHh0DQoNClRoZXNlIHR3byBkZXZpY2VzIGFy
ZSBzcGVjaWZpYyB0byB0aGUgdXNlZCBmb3IgZmFuIGxpa2UNCkRvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9od21vbi9wd20tZmFuLnR4dCwgYnV0IHdpdGggb3VyIHVzYWdlLA0KaXQg
ZG9lc24ndCBqdXN0IGZvciB0aGUgZmFuLiBJbiBvdXIgc2NlbmFyaW8sIHRoZSBjdXN0b21lciB3
YW50cyB0bw0KY3JlYXRlIGEgcHdtLWJlZXBlciwgc28gaGUgbmVlZHMgb25lIHB3bSBpbnB1dCBh
bmQgaGUgZG9lc24ndCBuZWVkIHRoZQ0KdGFjaCBmdW5jdGlvbi4gSWYgSSB1c2VkIHRoZSBwd20t
ZmFuIGFzIHRoZSBiZWVwZXIncyBwd20gaW5wdXQsIGl0IGxvb2sNCndlaXJkLg0KVGhlcmVmb3Jl
LCBJIHdhbnQgdG8gc3BsaXQgdGhlc2UgdHdvIGZ1bmN0aW9ucyBpbnRvIGRpZmZlcmVudCBkZXZp
Y2VzLg0KDQpJZiBteSB0aGlua2luZyBpcyB3cm9uZywgcGxlYXNlIGxldCBtZSBrbm93Lg0KDQpW
ZXJ5IGFwcHJlY2lhdGUuDQoNCg==
