Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F353135D8D1
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 09:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhDMH2R (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 03:28:17 -0400
Received: from mail-eopbgr1320105.outbound.protection.outlook.com ([40.107.132.105]:28353
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229762AbhDMH2Q (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 13 Apr 2021 03:28:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dB9JGS4YIHP08lNnm3ud7/52RY6e4eE0RjHIYq5ZzMeHkXrTDTMuCsbmuijhFbZsBDvVp05BfwbzVd6nxtqQWS78Wb3nNOYTHEUx+HpWXdY+CRD64o8NiMfojBEAc3aLMF+DzWAFwWvQWKnaJuy/fFuczMQdhe/X+VLYTLTgu7gtjP884Xwr1+xEAl1otQA4YyOLOrqmb78uLxBY42E7Udv9sIR5wAvHLP9DbDuPomKVryam0HpsXeKzs99OK4ANUZqZADC/e6h5Lca/QEyT2MOm8oZlEN7Q566jT8vbmFhTqJUYv2HLOeidXDwmJ4qoo5KU/tGnMrTGYZRAbX14jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3yRah5H8XiJYbstw4Y8mgFYyoO4ymXp3d+xbbKAfeY=;
 b=DSS2A61cR9fXI+vKtrkMfqPV2/aRG9DnUPYAc7je92VswFev0KTrPYPZZshwthO5jkFIsUk3KcEXS8T+MpEzokUG9BwrFhRfqB0zBAUBhWL5Hdx+P0IpvLjGqmxhducL9/6m/5/gV44znVMKK27hZH9ICpbxjfdzx6h86M/Yj9hfrC+jmqsWnhrw+V+3I+9fkXSrPmcCKWitAuPL6ccxK4e5L/pcywHjfPubq8h1YbLinoXadCeCSHx1Bqt1LGLGE9NNsIs8ZO3Mmo1HUmz0xISig9yWmmHiL71pbB2CCqfm0a9DdrFshiWvln4prbmj1W7rijXUTCo8Q6EheTvHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB2867.apcprd06.prod.outlook.com (2603:1096:203:5e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Tue, 13 Apr
 2021 07:27:51 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::4d49:12fe:2d9a:b1bd]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::4d49:12fe:2d9a:b1bd%3]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 07:27:51 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Subject: Re: [PATCH 2/4] dt-bindings: Add bindings for aspeed pwm
Thread-Topic: [PATCH 2/4] dt-bindings: Add bindings for aspeed pwm
Thread-Index: AQHXL4Hjk3xux308SEWBeke+D0GoN6qw3hAAgAG2DAA=
Date:   Tue, 13 Apr 2021 07:27:51 +0000
Message-ID: <106D8276-51DF-4319-BDB4-68D1C0B2971A@aspeedtech.com>
References: <20210412095457.15095-1-billy_tsai@aspeedtech.com>
 <20210412095457.15095-3-billy_tsai@aspeedtech.com>
 <1618233600.223110.3757979.nullmailer@robh.at.kernel.org>
In-Reply-To: <1618233600.223110.3757979.nullmailer@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bd0c2a9-9dd6-49cb-2fdc-08d8fe4da571
x-ms-traffictypediagnostic: HK0PR06MB2867:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2867307112E511BD4E81FCC38B4F9@HK0PR06MB2867.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RHlBqyR+a7yxzY1oFSplYvvk39FiRHLle/KZsqXvo21XPDF5E/J1Utd2W7Y+XMExvnvRDJ3A/+S+dky0gndwijvolWqj4z78jF9tq1WVMG8FcHHHRtnduz3a7Ugoa137pqqwfIyMNZdF8AgX1AsZppdQtq5wW4yX5gRU7gNi4/nxYKwGZa595ZePQI16PPqGn5AU6L6H5NT6vZzpLabdYRofNyzmZ7/F0lcxYpeWpaVVKB/xKKCSIWLfLT+hLVmI0zIwFCC5/zZNpXeStwrBpTK4tkT1Y/Zt+tJhKHLCrwDckpM0POkktfdR+20MX4qERa9QuXrRm6kpLfbfaPC1zPR39/gG1FGi+TJK5/Yas2Y6T1eAsBLnsDTCB3fsvE6yR1IvEcJKquMpgRz5LFQMIfV9/6hyiOMwJBo8kfleC1Y860wpYjycxbOfWbDvp8Ra4eDMY82uHYDFr2H5epLpRcEUNdyPgcsbuSeU92AanTvtnZp77ThkZ1ApyHdyTqpEKHTgjQUnHPeUi5RTxS2AegOy6mpZW3BNHX97vi83b454RlwqLoqndSuI1HR16XWTFdNe/T4ky7M5ltXmw/XCNn7b2db8OQH3y9B1I3/iEUlov7d9/zseW/WgdIWNvG5KHU+/lH82CV0fEwWdf6w4ZP0g1U9KIKSWaEi7Elz5jQTtG+7QdgaYaIGJ1tlOqJy16oj6OtkCp0R/wQlKgQrrfOvEujcnHmr1wMOtZaBVB1M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(39830400003)(376002)(66446008)(478600001)(64756008)(66556008)(6486002)(66476007)(6506007)(5660300002)(2906002)(36756003)(122000001)(54906003)(66946007)(6916009)(38100700002)(86362001)(8676002)(33656002)(4326008)(83380400001)(76116006)(2616005)(55236004)(186003)(966005)(71200400001)(7416002)(8936002)(316002)(6512007)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N2swQ2lnVm9tbWEyaXhoM0YzR1NVRFk2TFZUekltRGJmQ3VEanN3MnRJa1Rx?=
 =?utf-8?B?NzNXdDY1Y2dVZHBsbjQyYTN3NFhmTy8ra0k0dGhFRDBTY20xS05SRjNKTzdN?=
 =?utf-8?B?ZXk3MmZ1Sm5NcGlmWitTQlFXMHVSVTNVQVZPRWI5VS91eVB3cDQ2Vit3VUp3?=
 =?utf-8?B?elZzSmcrM0Q1ZG1MZXk2YlhvVGc3dUVUaERYam5DRUhhODJmOXdGVjFrMGJ1?=
 =?utf-8?B?V2hjWHAra21EV1pSd2tRTFc4cWlWQjJpMnNvUmN5eDRkR0xtUnZCYkJQRm10?=
 =?utf-8?B?bEZubktMcE5tdlBJUWFCanovRld6UllaZDZYa210RG1HNFltWnd4RmJmTHlD?=
 =?utf-8?B?dUhEQlRxcGR2bVZJeTFUU3pRWjhVWmd4b3dFSUE5LzNZR2U5Y2RJbDMzZWIr?=
 =?utf-8?B?bkdGRXhwMG1rQkQ1bDYydDNVOE1PSGNxZ2VsWm9FbmxjREROaXdEclMzWmFt?=
 =?utf-8?B?R0hOeWIvaFpyTVhGaVFtS1hieFl5NTlRSlJtMUhwVUdQczZWMUE5WEJaeERp?=
 =?utf-8?B?bmRCUkFDZHd5akxHNlBrdUhVMUZmZHNrL1F5aGxoZjcycTZrMDViLzljc0pR?=
 =?utf-8?B?T0hPeGE5UmZxNEZVUnZaYkhybjM0UTJZUFhzelFwV3EzaXdXelRWRFVXc1FE?=
 =?utf-8?B?VFdxaWl4WmtTU3RQdGdvOTZjbTdUZ3hGTmZRMllBeWVRZHdSMkxYRUxBRUcw?=
 =?utf-8?B?WXF0ajVVVXVWOVJsU2MrMWVwVGdpWEVyaUZWTURTVjhBUlFlT2U2bHFXUjRK?=
 =?utf-8?B?Ry9TY3RnU3M5YVRuYlJCNDczV2NreHNFWU85R2lPMGE5NlIzRzgyZGF2ZFJB?=
 =?utf-8?B?bTUySFQxL3NMRXBzTU1lM3FkQk92NkY5L2RDZ0VtZkJEZkYrZnVOOG5BR0ho?=
 =?utf-8?B?K1ZmZjU2Z1pmQUxMTUsxKzBQZWRyTkZmUlZaZ05tMThlU2JwcDF2VVM1VG1v?=
 =?utf-8?B?R0pSU2NIZzJIS3k0c2ZRa3hBdGlkODN3TC9hci9VTklsYXI0aGhqMWtxcFk2?=
 =?utf-8?B?QWhZQUFwYkY3VkZlOUlXRlFUZ3d0clIybllMSldGVjdPRy9NNzgzMFM3cUhI?=
 =?utf-8?B?S3hwaWpSRnNuaDlTU3R6Ry9FK1Q0NDRDbVFNeTB5SFZUamlocktkMlVrampR?=
 =?utf-8?B?b2lOaHZiaUpYMG5zUDFybS9Bck16L0hhODFyWmlrYWx1dWFnRUt0bnRNWVhU?=
 =?utf-8?B?T3p2YzUzNE55VEJacXJ2WTJuUE54QXRIL3VUZkhLb2NEdGUyWWhrOEJ6aDJl?=
 =?utf-8?B?NlJvdWRJY00wci9JTTVXMTk3RXByd2JlK0VUeENjb3RKWkl1VTdNZjdvbHpI?=
 =?utf-8?B?eUxxUWhvU0h2S3ZBT3B5R1lPUUQwbmNiU00yTU9XWStrWHVQb0dYWkpwZEt6?=
 =?utf-8?B?U2M5TzZhUkZkUUl4RktVSVcwNEZSdDFibXA3TmpTbjkwUmtQbTRXQlg0MEpi?=
 =?utf-8?B?MDZUcGRDWjlhUXRZc3hwaExtbHF4cWowTzg1V0t4OWF2VFZVTGRnOU9jZ1c4?=
 =?utf-8?B?VmRBL21EbFNZWGJycy9seWVxdU05Mi9jQkNrNFZQamZOMTMvNnZteHNUcExD?=
 =?utf-8?B?MDN3VFJRdUJacE5PbkFuTkJJUUlmbkZOSGlyTTBUUm0vTHdzRlg5Q3lzSWFB?=
 =?utf-8?B?UE5Md3pobk1MdXpHWmNVeC81cG9WN09UUnYxbUs1MzRldlVTOUJOaFhHcysz?=
 =?utf-8?B?N2ZQcjJaZFdGMGd3QWFLWTd5a2RvdjZ1THdxVUEvZlhzdm5BRlR0aDVkcnk3?=
 =?utf-8?Q?kbJA94PNiWN1fbVMfi8MY7339y22m99Sq2su+Va?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31A5211A6E16CD479C4A23874841E7D1@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd0c2a9-9dd6-49cb-2fdc-08d8fe4da571
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 07:27:51.3151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X2pIhbOzUM7z8uX55aPfcXBUo42aAkdh/bFCPVfB73DFfUJb4U+Oft1Y0/mrABe2P88NZ72Gbel4pQBtg+8zU2mN27p6EGmG6YAANXd3kGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2867
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgUm9iLA0KDQpCZXN0IFJlZ2FyZHMsDQpCaWxseSBUc2FpDQoNCk9uIDIwMjEvNC8xMiwgOToy
MCBQTSxSb2IgSGVycmluZ3dyb3RlOg0KDQogICAgT24gTW9uLCAxMiBBcHIgMjAyMSAxNzo1NDo1
NSArMDgwMCwgQmlsbHkgVHNhaSB3cm90ZToNCiAgICA+PiBUaGlzIHBhdGNoIGFkZHMgZGV2aWNl
IGJpbmRpbmdzIGZvciBhc3BlZWQgcHdtIGRldmljZSB3aGljaCBzaG91bGQgYmUNCiAgICA+PiB0
aGUgc3ViLW5vZGUgb2YgYXNwZWVkLGFzdDI2MDAtcHdtLXRhY2guDQogICAgPj4gDQogICAgPj4g
U2lnbmVkLW9mZi1ieTogQmlsbHkgVHNhaSA8YmlsbHlfdHNhaUBhc3BlZWR0ZWNoLmNvbT4NCiAg
ICA+PiAtLS0NCiAgICA+PiAgLi4uL2JpbmRpbmdzL3B3bS9hc3BlZWQsYXN0MjYwMC1wd20ueWFt
bCAgICAgIHwgNDcgKysrKysrKysrKysrKysrKysrKw0KICAgID4+ICAxIGZpbGUgY2hhbmdlZCwg
NDcgaW5zZXJ0aW9ucygrKQ0KICAgID4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9hc3BlZWQsYXN0MjYwMC1wd20ueWFtbA0KICAgID4+
IA0KDQogICAgPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgRFRfQ0hFQ0tFUl9G
TEFHUz0tbSBkdF9iaW5kaW5nX2NoZWNrJw0KICAgID4gb24geW91ciBwYXRjaCAoRFRfQ0hFQ0tF
Ul9GTEFHUyBpcyBuZXcgaW4gdjUuMTMpOg0KDQogICAgPiB5YW1sbGludCB3YXJuaW5ncy9lcnJv
cnM6DQoNCiAgICA+IGR0c2NoZW1hL2R0YyB3YXJuaW5ncy9lcnJvcnM6DQogICAgPiAvYnVpbGRz
L3JvYmhlcnJpbmcvbGludXgtZHQtcmV2aWV3L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wd20vYXNwZWVkLGFzdDI2MDAtcHdtLnlhbWw6IEFkZGl0aW9uYWwgcHJvcGVydGllcyBh
cmUgbm90IGFsbG93ZWQgKCdwd20tY2VsbHMnIHdhcyB1bmV4cGVjdGVkKQ0KICAgID4gL2J1aWxk
cy9yb2JoZXJyaW5nL2xpbnV4LWR0LXJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcHdtL2FzcGVlZCxhc3QyNjAwLXB3bS55YW1sOiBBZGRpdGlvbmFsIHByb3BlcnRpZXMg
YXJlIG5vdCBhbGxvd2VkICgncHdtLWNlbGxzJyB3YXMgdW5leHBlY3RlZCkNCiAgICA+IC9idWls
ZHMvcm9iaGVycmluZy9saW51eC1kdC1yZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3B3bS9hc3BlZWQsYXN0MjYwMC1wd20ueWFtbDogaWdub3JpbmcsIGVycm9yIGluIHNj
aGVtYTogDQogICAgPiB3YXJuaW5nOiBubyBzY2hlbWEgZm91bmQgaW4gZmlsZTogLi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2FzcGVlZCxhc3QyNjAwLXB3bS55YW1sDQog
ICAgPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL2FzcGVlZCxhc3QyNjAw
LXB3bS5leGFtcGxlLmR0LnlhbWw6MDowOiAvZXhhbXBsZS0wL3B3bV90YWNoQDFlNjEwMDAwOiBm
YWlsZWQgdG8gbWF0Y2ggYW55IHNjaGVtYSB3aXRoIGNvbXBhdGlibGU6IFsnYXNwZWVkLGFzdDI2
MDAtcHdtLXRhY2gnLCAnc2ltcGxlLW1mZCcsICdzeXNjb24nXQ0KICAgID4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9hc3BlZWQsYXN0MjYwMC1wd20uZXhhbXBsZS5kdC55
YW1sOjA6MDogL2V4YW1wbGUtMC9wd21fdGFjaEAxZTYxMDAwMC9wd21AMDogZmFpbGVkIHRvIG1h
dGNoIGFueSBzY2hlbWEgd2l0aCBjb21wYXRpYmxlOiBbJ2FzcGVlZCxhc3QyNjAwLXB3bSddDQoN
ClRoZSB5YW1sIGZpbGUgaGF2ZSBkZXBlbmRlbmNpZXMgd2l0aCB0aGUgZmlyc3QgcGF0Y2ggaW4g
dGhlc2Ugc2VyaWVzLiBJIHdpbGwgc3F1YXNoIHRoZW0uDQoNCiAgICA+IFNlZSBodHRwczovL3Bh
dGNod29yay5vemxhYnMub3JnL3BhdGNoLzE0NjUxMTYNCg0KICAgID4gVGhpcyBjaGVjayBjYW4g
ZmFpbCBpZiB0aGVyZSBhcmUgYW55IGRlcGVuZGVuY2llcy4gVGhlIGJhc2UgZm9yIGEgcGF0Y2gN
CiAgICA+IHNlcmllcyBpcyBnZW5lcmFsbHkgdGhlIG1vc3QgcmVjZW50IHJjMS4NCg0KICAgID4g
SWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2Vl
IHRoZSBhYm92ZQ0KICAgID4gZXJyb3IocyksIHRoZW4gbWFrZSBzdXJlICd5YW1sbGludCcgaXMg
aW5zdGFsbGVkIGFuZCBkdC1zY2hlbWEgaXMgdXAgdG8NCiAgICA+IGRhdGU6DQoNCiAgICA+IHBp
cDMgaW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3JhZGUNCg0KICAgID4gUGxlYXNlIGNoZWNrIGFuZCBy
ZS1zdWJtaXQuDQoNCg0K
