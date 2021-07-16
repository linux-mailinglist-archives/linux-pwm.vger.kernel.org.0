Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E7D3CB670
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jul 2021 12:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbhGPK70 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Jul 2021 06:59:26 -0400
Received: from mail-eopbgr1300113.outbound.protection.outlook.com ([40.107.130.113]:31537
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239617AbhGPK7W (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Jul 2021 06:59:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3Ce2lwJ4xxJ/GHDcqfpbUWktOKjXnamHv86zzWjtCVzLvrYHc8+ZaqpKpUIgQ72uhR6FC8UUy74O/Aqp84+Dkk62hRsjJ1dk5EB3U2rT09piZOoR4YZPhvNCF7XROsox8ckYQBjGDu3Imd8jAMN+BCa9G7S5ledgHMooVVjcqs0vpGfpn8cZRMLTguS++0I6sx3Q5IR6wW+ZtZIbIj/Njc+yQ2+2soSPHhv5NUvG/zbjdjVanmUj0j7DsAHxkaXYxtOXGJ1w8ozJgTtr9wdznENOcT8EqR97jW5DxsYO0jCDVC6bIiDALofO/q3y/KV72RY3PmPtoqIIhMlIP8D1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQxzkg2zyAiMIAWzKT9iP4AEqfr9t8Z2+a7LaJPNz1s=;
 b=e8EsU6y/rV27q7q2agmOCIjanDJqHe+4YzMxXBSVgnONFPRqAWHcgb4cmx2iH8yflJ0g9g9sMNUrsOwqwyP8A6rN9T3sBskPmfbIDb1uwjxPTLZCHhA4wCqZQGrJ/aYZNUr+J3XproAfFA/0fTaxAJFpwbsUtTP3GeRyN9OWdbDe0/TL+ej/JtNZnZ4wv2ItgRs1xR4ezeaoKH2cXmH+Ix7uUXVa78NUG89oauRR63EMzExiPIiq1GZta3MMwnSvzJ3O4V2Tcb4vR6NYTaHiYy4sWZjoLM90/twp+V8QiIgF54EmLI6qexQj0sDF0jTBybn1wr1TyHS5LQ9CqADwzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQxzkg2zyAiMIAWzKT9iP4AEqfr9t8Z2+a7LaJPNz1s=;
 b=N1+JkkwySHepz4wdM78Ff8FnDUXUApWignU/P5BOB9bV0DCX7xWXke6TVliw+C/uEEos7oMSlyP+vpwa85lRErOpCFUf2E/rg87Tpllpb8ipizvQIJm+5KPghEnMAkRUxalKpMLQPI2jPCtctxuhJQmY3h6CC/7fYMgVSNgYn0/B4CmAym0/zqcXNjiM4nYJIZir6n7oOhZXCWLZM6J3+7OWRlZhVgi83Lu+uwooXrb2uD2PcSad2/kWxfdQveZ5FEeEp6zM4bgNLaPcpFukUw+djSYEB+/qsIdvptZjGr9ro35TY5m/aNIoi+bolE6EcYt+XYaRdgUB5OLW8JNj4Q==
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com (2603:1096:203:8b::10)
 by HK0PR06MB3828.apcprd06.prod.outlook.com (2603:1096:203:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 10:56:24 +0000
Received: from HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27]) by HK0PR06MB3362.apcprd06.prod.outlook.com
 ([fe80::a529:f5b3:b9d6:5e27%4]) with mapi id 15.20.4331.025; Fri, 16 Jul 2021
 10:56:24 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [v9 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Topic: [v9 2/2] pwm: Add Aspeed ast2600 PWM support
Thread-Index: AQHXdI70LATZWzg1kUKYrs9wZPLHOKtELJmAgAE5s4D//9OwgIAAqykA//+IDYCAAJI6gA==
Date:   Fri, 16 Jul 2021 10:56:24 +0000
Message-ID: <3F12A498-DF5C-4954-8BCE-8C0C66BC9734@aspeedtech.com>
References: <20210709065217.6153-1-billy_tsai@aspeedtech.com>
 <20210709065217.6153-3-billy_tsai@aspeedtech.com>
 <20210715150533.vppkw5oiomkxmfrn@pengutronix.de>
 <BD5B012C-B377-45E2-B04E-61D12B086670@aspeedtech.com>
 <20210716070943.ayxkz2irkwhgincz@pengutronix.de>
 <DD5590B4-11BC-411B-95BF-03AC26C078E4@aspeedtech.com>
 <20210716101301.l563tdwt5xuq5iq6@pengutronix.de>
In-Reply-To: <20210716101301.l563tdwt5xuq5iq6@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ceb0c9d3-fdc4-4d16-f9cb-08d948485a82
x-ms-traffictypediagnostic: HK0PR06MB3828:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB38285EF37CB830D2DDB693A38B119@HK0PR06MB3828.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mjqsmtuXoB9QXjBpXzXubA+GYjag/oDIh38XTn/Py3K0P3BBYeBO9IFza9XpTQWM/XnQUwPWxW4THyWs6CdgJXhfOQXGyMy4p53xUdbMziYKuoUgz93m7Q4eqxuOqF8ZRLhnI7+br+5jCS6uDrszt58Nt/Ct69xfJZ2XesDC9xk3nLrGbH4n2Ww4cebSr/8ySLB7z9NLUSnleXluXb1B626I0EPgF3HbKceBOokMYMQx6QI8PcVFS0NSGmCoib7LfnLnzs81jgIW+aSoQDVY4zumgUhZQCrNpxYRADpU9wiCtY+gnefk+euVi4Q6ld892IsXBfY+KcfnunjWTYH4kCdQXRDknUzPKhhlL37geWhlSINhQmf/Bzbv99cBDPsTAnuprU4FegO/aXtE5fWNfkA+qrYk+NfJ7EbIjXVdDuxyeVygPCelTFuX4dxeYcoxVyVSlfacch0cNnhIAaOSn7GjpE/U/LnvcZW7oSJhkp6EmPtSEb5UQdJPdA2O8iwYPwt6jbvQdwMzFv1fwzFAISlCIG7E8GLozR5O7e01QTYLrovhSZMA20Y//XxTvABCHdySIpaeDNZ7yw2AfMUvWAloJ9hfw5h30CaVwcPHwmNXLMYFMF51kDmBYZ4QSwsuXyPlNj4ag9h6MTN8AVdykTzeNA93mEGN3aQU643S9Af+TOXEa8Yj8dm8iXaMQ9JsOHNFy6hXteBj0DsL61h2UMG4/mHRORC6zk/bbfKKz78=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3362.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(396003)(366004)(376002)(136003)(6916009)(66446008)(66476007)(122000001)(36756003)(6486002)(38100700002)(2906002)(6506007)(64756008)(53546011)(66556008)(316002)(55236004)(54906003)(76116006)(8936002)(8676002)(107886003)(33656002)(83380400001)(71200400001)(91956017)(186003)(7416002)(478600001)(86362001)(4326008)(66946007)(2616005)(26005)(66574015)(5660300002)(6512007)(38070700004)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWtlY005VzZIRmJIUzZ2YUVqdDBIekorNWV2eFY3NHVFa1dWclhCWFZzUVRZ?=
 =?utf-8?B?WWc2TGloMnYyR1hSTmQwcGFEM3BXMS9Zc3F3dlpYVU1EMXVwSDJ3ZlNCQXVL?=
 =?utf-8?B?bUxNTW1aanhMaktYalpqbDk0akJrYUx1TjZDRUxlOE9pUW9oWElQNWpUWVFt?=
 =?utf-8?B?V0hwWlA1VW9KL0RNNHlNZnlJL1lTZUpKWFNvUjZid2lOb2dRQk9BRXNSNkh2?=
 =?utf-8?B?WEUybk9SeUgwMWpkVHczZnpwYmxDUml0QjBtYjgrZ2p2aDN1YVlFWDB5NzY5?=
 =?utf-8?B?NnB0cFAvc1RQSlkyTjdKWC9vQlVLdWtsa1NQTXhJdkZkeHRTdHByNGhFZEhj?=
 =?utf-8?B?dlRHWnRXSWxjYzJlVytjemNWaEUrZElydFloNzBkTU5kcVFOb2hEZWFQU3BI?=
 =?utf-8?B?RU5obDJ1QTFHZnBYdjg0a0J1ZlVQaUl5aXp0Yk9wTUFCc0E1UFE2ei8wclpK?=
 =?utf-8?B?WlJvZmhaeThzS0xIYWtLaDl4d0x6UlZyMnZPVnpuV0NFcXlZRm1HZVoxYnFv?=
 =?utf-8?B?bUExaE9waHUyRUNoNi9wRzE4Snl4WGJadkU3cVMzL3UxZGxUdm1NM2dkMXgv?=
 =?utf-8?B?TDBZNGRpY1RyZXdidmJvend5RGtZcXRKeEJvK1NrTk9xNTUwK0UxdzU2UG96?=
 =?utf-8?B?OTNZRmNjTDNVQ3RHc1ZVS1VKYWNjbmRvbjVlU0dUWW8zbGlLUS9EM2pXck1R?=
 =?utf-8?B?WHZLdkg0VDdTYk1LWWVLeUxkTCtNZUZEMjdsNGNzL1hBMDh0YjhSaWtHMDdQ?=
 =?utf-8?B?UjlXREJQK2xTZmg5T1Y5RUZGTTJTRXVXZjVmdU40NUx1cmJyNmxJZENjZ3h1?=
 =?utf-8?B?UnRyMnQ5VHcxUVhtVXNxb2hPK2pzYVZ5bmtGbUs5bE5nSHNOZDV1Rk93SmFs?=
 =?utf-8?B?VDZHc1FXVFQxYStWd1RVQzdBcTVzTXNGR1FvYlRUeHl4OUhPMmgzOWE2c1Q1?=
 =?utf-8?B?dC96aU9MVWd6Mnd3K1BRRnpoL0l1ZjFkZUpzWlRnckR6TmRLdHNNdUNURlE1?=
 =?utf-8?B?QVpsY2c2S3Zzc1Zxa2VsY1F1cXRNYm10QkxnckRZOHQ4TlpmVTE0eElJSTZn?=
 =?utf-8?B?VzRJbWE0V095T2RueEo0ZUF2L1l0T2VCblJ2Qno0MGxqV2hFMThmVHYxaGx6?=
 =?utf-8?B?TXhlV2paeTBRRmZoYjVjYlF1bEVaWE1oUkhvd0JyeU1ZYUVRMStpd09zUER0?=
 =?utf-8?B?OVhJZTlTR0gvMllEUldNdDg4YlhqT2swZWZ2VC9ydk5OV3NXWEtjak91cGtG?=
 =?utf-8?B?Nm5VQzNFVkJDTmYzZk9wSnRIUlFrKzNhWXVINFZFMnBwa1pBc3c0enVTd2FB?=
 =?utf-8?B?a1drVEd4bHBmZDFRSW4wYWdJQzlYVWVqSmVlZjUra01Ya04wTzZ2M3ArcnpJ?=
 =?utf-8?B?cGZ2OUhZeHhJYzZtZXg1bS9NaTAzNlRoa3NKU2JuZTB0ak9TWDJxM2NjWU1S?=
 =?utf-8?B?WXVnMHFrWEtkK0dDcUtYZllXbHdMRTYxbTVuM2FRK3pVYldQMURzcDZnTXZp?=
 =?utf-8?B?UmM4NUNhVVpGcGR6SlkrbU00Qy9YbUlRc3V5RUErWEJUQWNaTWFhczFqaVZr?=
 =?utf-8?B?Z3dxQXRmWExLUDlpeEZZVEVjRGVoSmJsMkZLcnpKOFpvSG45R0JGUmdMYTE5?=
 =?utf-8?B?NFJYODJvVHBRM2hyNVNuRUJZdzFxT3VPRDZWLzVua3A2eGlFUWppTkdMS2N6?=
 =?utf-8?B?QkxDd0NvSHVkYjc4OTdWY3Z5aUdFbVlqSVpCNUhFN2dpQndyeXZDbWNGcXYz?=
 =?utf-8?Q?3WRGmXOjb0N/JJXsj/McgY1xT+3c4myaJh1i0aM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <753259CA98CAF14CB77F94A06EE29599@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb0c9d3-fdc4-4d16-f9cb-08d948485a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 10:56:24.1864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BvQlYbT0gNH6tDN7EHXyYe48uQwHPSEjz7beFqPAoXyKLikm0epx98yOoM9EPVELTDycdyfB0xpqjpdY/vlrRiiEel0cOtC4tkjPGRwtOOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3828
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQpIaSBVd2UsDQoNCk9uIDIwMjEvNy8xNiwgNjoxMyBQTSwgIlV3ZSBLbGVpbmUtS8O2bmlnIiA8
dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPiB3cm90ZToNCg0KICAgIE9uIEZyaSwgSnVs
IDE2LCAyMDIxIGF0IDA5OjIyOjIyQU0gKzAwMDAsIEJpbGx5IFRzYWkgd3JvdGU6DQogICAgPj4g
T24gMjAyMS83LzE2LCAzOjEwIFBNLCAiVXdlIEtsZWluZS1Lw7ZuaWciIDx1LmtsZWluZS1rb2Vu
aWdAcGVuZ3V0cm9uaXguZGU+IHdyb3RlOg0KICAgID4+IA0KICAgID4+ICAgICBPbiBGcmksIEp1
bCAxNiwgMjAyMSBhdCAwMTo0ODoyMEFNICswMDAwLCBCaWxseSBUc2FpIHdyb3RlOg0KICAgID4+
ICAgICA+PiBPbiAyMDIxLzcvMTUsIDExOjA2IFBNLCAiVXdlIEtsZWluZS1Lw7ZuaWciIDx1Lmts
ZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+PiB3cm90ZToNCiAgICA+PiAgICAgPj4gICAgID4g
QW5vdGhlciBpczogVGhlIFBXTSBkb2Vzbid0IHN1cHBvcnQgZHV0eV9jeWNsZSAwLCBvbiBzdWNo
IGEgcmVxdWVzdCB0aGUNCiAgICA+PiAgICAgPj4gICAgID4gUFdNIGlzIGRpc2FibGVkIHdoaWNo
IHJlc3VsdHMgaW4gYSBjb25zdGFudCBpbmFjdGl2ZSBsZXZlbC4NCiAgICA+PiAgICAgPj4gDQog
ICAgPj4gICAgID4+ICAgICA+IChUaGlzIGlzIGNvcnJlY3QsIGlzIGl0PyBPciBkb2VzIGl0IHlp
ZWxkIGEgY29uc3RhbnQgMCBsZXZlbD8pDQogICAgPj4gICAgID4+IA0KICAgID4+ICAgICA+PiBP
dXIgcHdtIGNhbiBzdXBwb3J0IGR1dHlfY3ljbGUgMCBieSB1bnNldCBDTEtfRU5BQkxFLg0KICAg
ID4+IA0KICAgID4+ICAgICA+IFRoaXMgaGFzIGEgc2xpZ2h0bHkgZGlmZmVyZW50IHNlbWFudGlj
IHRob3VnaC4gU29tZSBjb25zdW1lciBtaWdodA0KICAgID4+ICAgICA+IGV4cGVjdCB0aGF0IHRo
ZSBmb2xsb3dpbmcgc2VxdWVuY2U6DQogICAgPj4gDQogICAgPj4gICAgID4JcHdtX2FwcGx5KG15
cHdtLCB7IC5wZXJpb2QgPSAxMDAwMCwgLmR1dHlfY3ljbGUgPSAxMDAwMCwgLmVuYWJsZWQgPSB0
cnVlIH0pDQogICAgPj4gICAgID4JcHdtX2FwcGx5KG15cHdtLCB7IC5wZXJpb2QgPSAxMDAwMCwg
LmR1dHlfY3ljbGUgPSAwLCAuZW5hYmxlZCA9IHRydWUgfSkNCiAgICA+PiAgICAgPglwd21fYXBw
bHkobXlwd20sIHsgLnBlcmlvZCA9IDEwMDAwLCAuZHV0eV9jeWNsZSA9IDEwMDAwLCAuZW5hYmxl
ZCA9IHRydWUgfSkNCiAgICA+PiANCiAgICA+PiAgICAgPiByZXN1bHRzIGluIHRoZSBvdXRwdXQg
YmVpbmcgbG93IGZvciBhbiBpbnRlZ2VyIG11bHRpcGxlIG9mIDEwIMK1cy4gVGhpcw0KICAgID4+
ICAgICA+IGlzbid0IGdpdmVuIHdpdGggc2V0dGluZyBDTEtfRU5BQkxFIHRvIHplcm8sIGlzIGl0
PyAoSSBkaWRuJ3QgcmVjaGVjaywNCiAgICA+PiAgICAgPiBpZiB0aGUgUFdNIGRvZXNuJ3QgY29t
cGxldGUgcGVyaW9kcyBvbiByZWNvbmZpZ3VyYXRpb24gdGhpcyBkb2Vzbid0DQogICAgPj4gICAg
ID4gbWF0dGVyIG11Y2ggdGhvdWdoLikNCiAgICA+PiBUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlv
bi4NCiAgICA+PiBPdXIgaGFyZHdhcmUgYWN0dWFsbHkgY2FuIG9ubHkgc3VwcG9ydCBkdXR5IGZy
b20gMS8yNTYgdG8gMjU2LzI1Ni4NCiAgICA+PiBGb3IgdGhpcyBzaXR1YXRpb24gSSBjYW4gZG8g
cG9zc2libGUgc29sdXRpb246DQogICAgPj4gV2UgY2FuIHRob3VnaCBjaGFuZ2UgcG9sYXJpdHkg
dG8gbWVldCB0aGlzIHJlcXVpcmVtZW50LiBJbnZlcnNlIHRoZSBwaW4gYW5kIHVzZQ0KICAgID4+
IGR1dHlfY3ljbGUgMTAwLiANCiAgICA+PiBCdXQgSSB0aGluayB0aGlzIGlzIG5vdCBhIGdvb2Qg
c29sdXRpb24gZm9yIHRoaXMgcHJvYmxlbSByaWdodD8NCg0KICAgID4gSWYgdGhpcyBkb2Vzbid0
IHJlc3VsdCBpbiBtb3JlIGdsaXRjaGVzIHRoYXQgd291bGQgYmUgZmluZSBmb3IgbWUuDQogICAg
PiAoQXNzdW1pbmcgaXQgaXMgZG9jdW1lbnRlZCBnb29kIGVub3VnaCBpbiB0aGUgY29kZSB0byBi
ZQ0KICAgID4gdW5kZXJzdGFuZGFibGUuKQ0KDQpUaGUgcG9sYXJpdHkgb2Ygb3VyIHB3bSBjb250
cm9sbGVyIHdpbGwgYWZmZWN0IHRoZSBkdXR5IGN5Y2xlIHJhbmdlOg0KUFdNX1BPTEFSSVRZX0lO
VkVSU0VEIDogU3VwcG9ydCBkdXR5X2N5Y2xlIGZyb20gMCUgdG8gOTklDQpQV01fUE9MQVJJVFlf
Tk9STUFMOiBTdXBwb3J0IGR1dHlfY3ljbGUgZnJvbSAxJSB0byAxMDAlDQpEeW5hbWljIGNoYW5n
ZSBwb2xhcml0eSB3aWxsIHJlc3VsdCBpbiBtb3JlIGdsaXRjaGVzLiBUaHVzLCB0aGlzIHdpbGwg
YmVjb21lDQphIHRyYWRlLW9mZiBiZXR3ZWVuIDEwMCUgYW5kIDAlIGR1dHlfY3ljbGUgc3VwcG9y
dCBmb3IgdXNlciB0byB1c2Ugb3VyIHB3bSBkZXZpY2UuDQpJIHdpbGwgZG9jdW1lbnQgaXQgYW5k
IHNlbmQgbmV4dCBwYXRjaC4NCg0KVGhhbmtzDQoNCkJlc3QgUmVnYXJkcywNCkJpbGx5IFRzYWkN
Cg0K
