Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7538389ABC
	for <lists+linux-pwm@lfdr.de>; Thu, 20 May 2021 03:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhETBIJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 May 2021 21:08:09 -0400
Received: from mail-eopbgr1310105.outbound.protection.outlook.com ([40.107.131.105]:64013
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229498AbhETBII (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 19 May 2021 21:08:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoBrvTyXNLV8hIKhf17llJ9htz8zc2LbY0D66um1SegaMN2kYMwjy1iISkHxylM1z5AgEjp+RSGIM9tTK14fFpUsliF9Gm6vtxgQzmxSpy9fqINQQ21btMnKQUzQMd+xtkjc2n3Mpd0MNAntf6c7yp6hwTpKvAAmgwNBCNv2XvH9Sof+b4WtZrKCowknGttvUlnao3jg7/dKmZiAKl48IHVoPvOe3lXPG+lyh0Hh0y6b57Jlun++As6YeS/M59uw6SqNy6wCngSGnSL06j9zCxukcJrSNFYgV0Gi3jCXYkvxr9IP4oSIv+NrQg9OO4Dep/6tTylJArKFfx0Wuqqj7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc568JM3g4uZLAgs8GF3WlhNaCtaZ/vqh+8wA2yu9h8=;
 b=TnOS9k8NIeqHdVfBT4/7JrbqVjTklY1gTwfrfqRmXhv8UqYDtn5e6ke11LDGc7G37Qurtk5ooZrwcOhxdO2lUwGFaixJz2/4IZhfxX3Bm47o8w6LIvaJqsT9dv8GpOA7snS5nEnCMMHgstFY7l8/tfKVKDI0XHrvF7kSGbSnhPrFrtAywAS+sJ3A8C4sARB3/gqWENGfZU+43UFFjFp0z7iW+Hpube2o1UZ+CYJa8WHBhlDd2Kju02iJ/d1dydxujx7mkwNstKyTnI01lIXmiX1G7yTakhC4rpIagJCHxVYcnzRepof3Q/RmfuvgynjBkK4vpNKhTiypn9ZYRLjfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc568JM3g4uZLAgs8GF3WlhNaCtaZ/vqh+8wA2yu9h8=;
 b=ZszyyV5gaednbDGLoXJh+W8kRa3PaQw4mv0823BE3hkZAuZdRMBRe9bMsCnomt0A+B9t4hZ6e5F5a0MjxPLjM6cFEcsSXj9rjGMkXs2B3BpgA7SIfgji2khjr6LIMhZgeDOwCH6RDXiAw9cz6ZZCqoLm9aeeCwnntOhvst4pi5jWidQaafEqJERLhWyiqDRJC5rTd7LoFeuFylhHsV01ZWDcG8ye59ZYipZJWNY81MV+G98pCMtc+B3SUBcB8SnZTBkxHouGoaKVGXHWcbo5cX9LF7rA/kDSZ5rNs6Z8FOuP5XX6v0kEzRmCICtgMkMvrghXcFSDw9jC4kU9pY+l/Q==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK2PR0601MB1891.apcprd06.prod.outlook.com (2603:1096:202:a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 01:06:43 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::58:9144:f232:6918]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::58:9144:f232:6918%7]) with mapi id 15.20.4129.032; Thu, 20 May 2021
 01:06:43 +0000
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
Subject: Re: [v6 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Topic: [v6 1/2] dt-bindings: Add bindings for aspeed pwm-tach.
Thread-Index: AQHXS4BqdB0ayjhGFUqmRwq8BhHU4qrrQbMAgADWMgA=
Date:   Thu, 20 May 2021 01:06:43 +0000
Message-ID: <37458AA4-17E4-4329-88A1-C18C0AFC47D5@aspeedtech.com>
References: <20210518005517.9036-1-billy_tsai@aspeedtech.com>
 <20210518005517.9036-2-billy_tsai@aspeedtech.com>
 <20210519202004.GA3566127@robh.at.kernel.org>
In-Reply-To: <20210519202004.GA3566127@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a334a8d5-e6b6-4035-2bc8-08d91b2b8859
x-ms-traffictypediagnostic: HK2PR0601MB1891:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK2PR0601MB18918C29A2C2511D307E15CC8B2A9@HK2PR0601MB1891.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k9xDELfey79+KXBNwJWb7ehV0ceCszok21m/gUtnYcOOsTT85oaoCbbd1pAiV71I9n7UNhY1xZEU8nRsC0E4CWtcUjlMNJy32dIwaWZcyUJB0sOLTLdEx74h5P8/RXN8JZpIrpOwCB8vrTUJpf9fziR+JAeJJYtom54tDyhVc8FSl0TYA4EzVi2N08nsJcyJPHQYNe9e1BCIPj7lSfwkacyubK5HZipZxGUu+7AlKNmL3kfqKWMRikVsKyavFwNIlwK9Dkwp6+rH3jhz4AZ9GwVYGCbxemc6mzFEB4rtxFbonsbwtMM9mMItmVJpfeRU640bkTYuzc95mO0yq3ZPMORab0W8Vo9Y7xrBxsqzwpTPwocVMCWh+MAELuxRnk+C91SPG5OnAhOQCJCEKW9ajs1H0DldDxzQK9IsznQwP7YC63BCVM0JC72qIZosKoaxNFF6wXCtCfmw+zkJNZtDih3SZ5Bv9J2tWWFrZKW3RiWMebDVfjxOmJpeP8ISqAR7fPmHRzVvljFGPwFEzx66wdrqnnkvDjXVr7fKxAl08c9zy61YkvYIMH8/Hhf0E5n1AUw5Z1JU16zzDzlpuXkphcmBE8H+yIuqXSQ6iBRiHCJ8hX77/UGDiHOvUdo5UHtiXjdjb4T0ZkPHIR7uF1H7kdtzGiDiRTrfIj+1V3zk51Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(366004)(39830400003)(376002)(6486002)(33656002)(86362001)(76116006)(38100700002)(83380400001)(122000001)(7416002)(66946007)(478600001)(316002)(8936002)(6916009)(6506007)(4744005)(5660300002)(6512007)(55236004)(2616005)(107886003)(71200400001)(54906003)(4326008)(66476007)(186003)(64756008)(8676002)(66446008)(26005)(66556008)(2906002)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dUpUUEJIMVoyYTNXVnlzbTFhK2l1UXdaazBKdlNHZWVKMFB1OHl6ck1rOHcv?=
 =?utf-8?B?dHd2VmZWSlFpOGFZME5XWEl3TlpMN0E1eXpZU01GVjhBWG9UYktyU1lndkJT?=
 =?utf-8?B?RmlUekY2TXZGTkJlZm54NXZNYWxZMGlKZTEweEg4Sy9Ub3p0RlFwZjdoM2dP?=
 =?utf-8?B?OC9rek9XbXpBcml2djZkV1d5c25tRjBjL0lMcVBOMGNKV1BYWnVITXNrb24r?=
 =?utf-8?B?NWdmM05QVzdEME5FUzVrYStKTFZaNXdYVkppU04wbnZ2eEpLS0F0VGYxdk1s?=
 =?utf-8?B?V3VqblNLM3hackE3eVMzKzBKcWdCeGs2L2RkRU8wNDk0b2FnL0ZwZjJHOWh6?=
 =?utf-8?B?ejBYUWozVXBYclo1ZVVORSs4ejVuRE13UzB3QW9OMUpvWjNJRHR0cHFEckIx?=
 =?utf-8?B?Z1lyM0pCSzU5bmd4eTF6YkhiUE1lK1RqVzdjUDdQVUtuQlNqUlZLWmtZSFFR?=
 =?utf-8?B?RmpKanJ5Rmo0bDRtS2Qrd29SdGNzcFN3RTZ2S052aUh1TFpiRHl6QWdGZGdq?=
 =?utf-8?B?NTBvblhtaEJUbk5FQWxWTVpVTkdNbTBnNUVaY241YmpmemNrS2dKNFcxNW1V?=
 =?utf-8?B?TENMc3psZHJCMXZMWTNFenlOb2pzQ3V2OHBoSE9BckdsSmhDdHJ3KzE0SUhU?=
 =?utf-8?B?YlljSTB1R3I5Mk1NVXg0emtaS2o3N1pQZVU3WXpDVEROME94VEtUUURMRytB?=
 =?utf-8?B?TEhoRFIxejJEV2xSSUJVTmFNVFdDalV0cTd1ZlpQOTh2aHZ3QUNXenZ5MXRK?=
 =?utf-8?B?cXUvajFBYS9adUd1R2wvOU5zOWtIZ3MvUzVkMHFlUW5yYnYvYzhkWXpyZ3JK?=
 =?utf-8?B?UlN3dVJ1VDZ4THBTN3h3ak5DY3lFeXM0cFcwUmhCVUswWnJkWFVkbXorWHlL?=
 =?utf-8?B?SWQvbk02S0ZIem5zd0dwM1JCdllaaFNOUDJGRGdFY0QyYVRKeTY5Z05aZ05G?=
 =?utf-8?B?U0kzVnFVNU80NDl3cGh5Z0E0OW9BNWZhVlkvdzdqeWU1NkdDUnFBQ01ob1Ny?=
 =?utf-8?B?UnNQaVVWSGpNWVFwcm4yaExvQWxaaU1iUnR1SmpNNk84QlJBc1EzbUczV0hO?=
 =?utf-8?B?RWwvOTkrblJQcHA4NUQvMWlEM0puZW9qbkgxRFFKaHBLL0d5VHFkM1JUUnZ5?=
 =?utf-8?B?ckNxaTNNbGtJTTdySlVMaWlPcjNPQWVhSklLeitUUFF0SG5peld4dnd4QjJv?=
 =?utf-8?B?NnVmWU1LOFM3emlqc2drRWVaTmo4YkpSdWQ5clN6QTgvSDVBTElOZlNPK1dk?=
 =?utf-8?B?K3JtVS9LUjRXdmFScjVpQnlkeVlEa01VRTg1NW84WGhRZWdhb1hoaU9UYzNa?=
 =?utf-8?B?aU43NVZpK0ZqN0FYTm5CbU4vY3FIWVRyZUhTV2ZwUVFJazZIYkZsdXk0bERJ?=
 =?utf-8?B?bERZRlhGNUlXWC9uaC9XemFmdUJFb3U4RUVEMlBrVXB2eFhMSUkwMFdWKzB4?=
 =?utf-8?B?QU8ybS9yalNudW4rQXdTQVVxcXArKzNvR08yN0d6ZWVyWXlkdlJ2a3JqbDhm?=
 =?utf-8?B?bGI1VXVxWnJlWE9Yc1JhV1d6R1BsZ1FiVlRaaVIrTkJJdzEwK1FFN1E1RjVm?=
 =?utf-8?B?a3hlTDFVMjBTUlpYbW0vZ1NqZFJZUmt6UHlOS1NKY3VheTRzY1dXNDZ4S01I?=
 =?utf-8?B?RG1ldVFGVEh0KzR2VTdiK1c2RnIvaG1POSt6U2UvTHA1SjdOL3NycCtQTjVR?=
 =?utf-8?B?WXdVeG9wSmh4Nk43UEpPaTBST2FjK0xGZEZzcEpwT1RtTXlGL0o4RmhUaFNl?=
 =?utf-8?Q?5s8aZR9AT7P5miefVtxcVRxmyGegO5oS6tZfy1j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE8648D8001FF04FBB725D7BD6012DE3@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a334a8d5-e6b6-4035-2bc8-08d91b2b8859
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2021 01:06:43.1786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hSK+QvUETcoVxq85bqAFnHil5xA39NDJX8U03i0Gg1ftDhfsx7sPzm47suVSEDBKf6ap+vMYzaPuZzkAlWZ+24tvF9WWM0XmzYP2v9b+RU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0601MB1891
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgUm9iLA0KDQpPbiAyMDIxLzUvMjAsIDQ6MjAgQU0sUm9iIEhlcnJpbmd3cm90ZToNCg0KICAg
IE9uIFR1ZSwgTWF5IDE4LCAyMDIxIGF0IDA4OjU1OjE2QU0gKzA4MDAsIEJpbGx5IFRzYWkgd3Jv
dGU6DQogICAgPiAgID4gKyAgICAgICAgfTsNCiAgICA+ICAgPiArICAgICAgfTsNCiAgICA+ICAg
PiArDQogICAgPiAgID4gKyAgICAgIHRhY2g6IHRhY2ggew0KICAgID4gICA+ICsgICAgICAgIGNv
bXBhdGlibGUgPSAiYXNwZWVkLGFzdDI2MDAtdGFjaCI7DQoNCiAgICA+IEFyZSBwd20gYW5kIHRh
Y2ggc2VwYXJhdGUgaC93IGJsb2Nrcz8gDQoNClllcywgdGhleSBhcmUgdGhlIHNlcGFyYXRlIGgv
dyBibG9ja3MuDQoNCiAgICA+ICAgPiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCiAg
ICA+ICAgPiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCiAgICA+ICAgPiArICAgICAgICBw
aW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KICAgID4gICA+ICsgICAgICAgIHBpbmN0cmwtMCA9
IDwmcGluY3RybF90YWNoMF9kZWZhdWx0PjsNCiAgICA+ICAgPiArICAgICAgICBmYW5AMCB7DQog
ICAgPiAgID4gKyAgICAgICAgICByZWcgPSA8MD47DQoNCiAgICA+IEhvdyBkb2VzIG9uZSBjb25m
aWd1cmUgd2hpY2ggUFdNIGlzIGNvbm5lY3RlZCB0byBlYWNoIGZhbj8NCiAgICA+IEV4aXN0aW5n
IGJpbmRpbmdzIHVzZSAncmVnJyBmb3IgUFdNIGNoYW5uZWwgYW5kIGFub3RoZXIgcHJvcGVydHkg
Zm9yIA0KICAgID4gdGFjaCBjaGFubmVsLiBQbGVhc2UgZG9uJ3QgZG8gc29tZXRoaW5nIGRpZmZl
cmVudC4NCg0KVGhlIGZhbiBub2RlIGluIHRoaXMgcGxhY2Ugc3BlY2lmaWNhbGx5IHJlZmVycyB0
YWNoIHBpbiwgbWF5YmUgSSBuZWVkIHRvIGNoYW5nZSB0aGUgbmFtaW5nIHRvIGF2b2lkIGNvbmZ1
c2lvbi4NCldlIGp1c3QgZm9jdXMgb24gdGhlIGZhbiBwcm9wZXJ0aWVzIG9uIHRoaXMgdGFjaCBj
aGFubmVsIGhhcyBub3RoaW5nIHRvIGRvIHdpdGggcHdtLg0KDQogICAgPiArICAgICAgICAgIGFz
cGVlZCxtaW4tcnBtID0gPDEwMDA+Ow0KICAgID4gKyAgICAgICAgICBhc3BlZWQscHVsc2UtcHIg
PSA8Mj47DQogICAgPiArICAgICAgICAgIGFzcGVlZCx0YWNoLWRpdiA9IDw1PjsNCiAgICA+ICsg
ICAgICAgIH07DQogICAgPiArICAgICAgfTsNCiAgICA+ICsgICAgfTsNCiAgICANCg0K
