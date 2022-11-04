Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CEF619DD9
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Nov 2022 17:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbiKDQxi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Nov 2022 12:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiKDQxI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Nov 2022 12:53:08 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2099.outbound.protection.outlook.com [40.107.114.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE25529C9C;
        Fri,  4 Nov 2022 09:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMSSzKlCIaT7Zmo0MhOZxT/ctLUscVvN7N02oMZaLmg0WBbps7JMuBzgURkzYfy1/v9t8fnuHuS83Ftqc5H05/6JtvXcOZD50hgL1tY1qIe/dP6r/lmpMUNYIWwMmWJSvSSurMrqY1boqp006cEZCWeQPSEqpp3ExhxEH+R5LY+/15ea/NCYyI70kPllQ1rreK+LJcZ2fApIdsKBF/ICp8NIvySw3Dqrrjzlt2KMHICEDB3C+yfx66tflN+SSfkUP0xsDpr8Bbx2t49+WgooSwjgiaPjQykG7WGVwMKOcf/NFFoRXO4rVwSCkPEnXk5cpx0gqDap3OnhtDhtVB94ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAiwAG1gB0byQaIbjdJIHD+j/xgSeZ9fd+mSqUzdy1M=;
 b=RM1tsi3fv6IUR0b9voPdN34ziKVYhnLn3WG0mzWysYl8SHN0CgF7UcGOeoorpfnUxgQiNwNviBEh0jBOY6IkLADC8nMCMqdgFMM68ZFIeUovG3n/7TBPAkl2Ep1SmQuHejBjSshyiGj/zNoTnFi+0b8Xfy9/0Qt+18Ttkgo1/B/OCqGF9g817ixFggNCQrTInPfa8BoRI9CRfjTSbtGi0QLc83sD0UIFMlDp6PbxoQv14vXtgBLrrmNeQCig8sTdTTqs3bwzfYXSuy9jsPfPOFUoe+xbgo8F9ltQ0NE4wM2rSdycPmD6BSx12sVB+iHYUlXRZHU4AJJ+yAZNhrPwDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAiwAG1gB0byQaIbjdJIHD+j/xgSeZ9fd+mSqUzdy1M=;
 b=h5QfQApKMG859HDUTnaoM0MlkDpxF5MLb/EzUxzuNbbOCRpWDFEyrJmp9lGzvudjUrf6m8xA9GgMOgvbftxHZsgI5JmzXXe/qAkTiA2jWzxLD8W+UOcDBbG9M9/5wZyYJTu4c2IjQOzxgZe7tLyu6RbgXgt4clt50agwjprKKjE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYYPR01MB8184.jpnprd01.prod.outlook.com (2603:1096:400:f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 16:52:22 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.023; Fri, 4 Nov 2022
 16:52:22 +0000
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
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/3] dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs
 property
Thread-Topic: [PATCH 2/3] dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs
 property
Thread-Index: AQHY8F4Z0M4T+LP7zUaTYMhsdADakq4u3OCAgAAdImA=
Date:   Fri, 4 Nov 2022 16:52:22 +0000
Message-ID: <OS0PR01MB5922D1D1143BB6F83A894D0E863B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221104145938.1782464-1-biju.das.jz@bp.renesas.com>
 <20221104145938.1782464-3-biju.das.jz@bp.renesas.com>
 <dea44f32-e10f-0164-0175-4fe2e5d053a2@linaro.org>
In-Reply-To: <dea44f32-e10f-0164-0175-4fe2e5d053a2@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYYPR01MB8184:EE_
x-ms-office365-filtering-correlation-id: c50d54c5-1075-4b08-32a2-08dabe84f1da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zV6RgojP5MoS2Z9arQ3YVMhGh++/oGoh7UIvqBYi6Gz8fwXCmbWJMk779R8aEvE5slewa8b2Z7mlkbXEnO/P75AtNs3M/btqPQ9bmHjcQk543lGvqNFAcdrgL2SOrkHBc6+9Eo7eYG0fxkvQKT8V0K4g1j+Ls56/wLCVVzSnOtIeu0nJ8TXioxl04lT7vvq/xj/rjIgrrypxviy46LYog9dY08PKiKvaDBnKcakdBudvW9VXQ9LmpmQohcKsku3C8OXLjK72GP9A5YSOkWfQ3vdBSPxcjHccrMjvBwKHx+eXQbIodp1HDZcxpr8BdfGFD4ixwcq/PtyAnYgxt3Q+DjZVZgugJ4XUkxo4PXb3Bqr1fDqjcV1Q5TptpzGzNRHwNzCjwdgVlrHvmF4fHXt+QuPXwVrEgxxCIrn5dEQjKw7AEvjTTA68IgHSPMrRQUvjPaF1h289Z/x6GvH9JWYfcWMuNhxEQQlZVIMHz77R4YHVvvYjg/VyfF3pRQn9iatQahTlHfXWOhY9aLhPNKSPzcTvaulfhnYJT8E+ATVn9HvAdL7VeA0Wr7vXYI+RcXiAiLBuErTVPHYkneRe4unjQU3hRHrRe5Hg1RgkN4AABbfwIB4m8zcXYEJYPo8e3Co0ajiB5/QBWb/ueaA6B7dz5qAfzMeb66wFjCD4sIB9yZ6LAEByoJn0eWQRJZe0i1XAC2CyqTF288DwTax2cFCOtMFI15+XcAOi6Km8WnWmzVJbAsJxVv2KscAW76YKbVztl+39EEyujfQMF4G8K38stw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199015)(66946007)(38070700005)(66476007)(55016003)(33656002)(86362001)(9686003)(41300700001)(26005)(66556008)(4326008)(76116006)(8676002)(8936002)(186003)(5660300002)(6506007)(71200400001)(478600001)(53546011)(7696005)(64756008)(54906003)(316002)(110136005)(122000001)(52536014)(38100700002)(83380400001)(2906002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGZyOEJ0MkM1SVlreTdPY0xYaDd1aC9QTytWclBuOWl1akJjOG5qR0JqZndB?=
 =?utf-8?B?SXlLWXJRQnUyYUxvUm5FM3hON29zTE45bnpvWnA5MlcwU05hZVpvOXNWWWd6?=
 =?utf-8?B?K1BxMGJjUUFSZkpiVEhUbzBlblRHdEZ5bHowcUd6LzNMQmRqdXA1c3FteTVS?=
 =?utf-8?B?ZlNHaXVIN0IwTXRnSGRXMDJSSTFlcndIRlIwcXJYYU03TGFVazZMMTU3dlE2?=
 =?utf-8?B?Ym9Tb0JTdTU3bTkvUERWMzBTWml0REFNYjY1YjNhdGx2Yzk3eXk0VHVTWWVH?=
 =?utf-8?B?VWJiaCsrbW4vK3RNV3JXTk1sdXNlUFFjRjNJRWZwd0dGYmt0dHFtdytoZFhG?=
 =?utf-8?B?QzdidXROcnBZMnF3bEhIZVhHS3MwQW1ibmp3bWpFSnd3SDdLc2tsam5vMEI3?=
 =?utf-8?B?OUdqdzg5dUNlSlJQVXd4VXhSK3ZRM2VFU1BXS1VUTm1iaUFQVDlTb013R0M0?=
 =?utf-8?B?ZlN2NlRZZUY0ZitpaVlXVjFUTU0xbDdjSWRKWjJSdHlTaHZ3K0p1WGFDeWhn?=
 =?utf-8?B?elpBNVF2eHdDM2M4YXRhYk1iYmQybGRjeExjNTRSUkJZcHVRYWxoNnpXdzB2?=
 =?utf-8?B?S1k1MmdmczlqbTFEMndpanY3QnVvVFNMckhEUkVicGxhZU9uSnB1WFBPYllz?=
 =?utf-8?B?UEE2RzdCbG1EeXJ1ZG9PdHZvOEZSOSt2S1Fob1ZTaWJmYi9sNUsrQ1F0eU1r?=
 =?utf-8?B?SjJ0QkROSlZnbUJSc0tkMmZReENOWGZ1ejJBRjJNVEFDSldQTm0zcFNZRlgz?=
 =?utf-8?B?eTdqczF4bmVMZ3NCSG5YTTdsaE8wRFh4RkNMOW92UStNQjFGZ0lSa2U1R1lm?=
 =?utf-8?B?SDQwNkRSRlJVZG9QL25oQWd4RllLZDZjTDAwQzBZRkRNbVlCRkJWUCs2R0pq?=
 =?utf-8?B?ckhtRCs3QWI1bDJUeGo1QkdGb1pBSEJjdU5UbHFOMkxtZE5xQ2xRWE5nNGVZ?=
 =?utf-8?B?VmF5WTRPVU9adG14ZVZJQTBza3hOUXZUbXNEczdEVWNnampxdER1TlZwcm0w?=
 =?utf-8?B?c1QySytmY2RXRm9jQWdiaUNZaGI0ZVNoR1BqNmQybVphaVZMWXhxMGU5dk14?=
 =?utf-8?B?UlR5eERHNnEvSkErZTdSTzBzZUU1clF1WHQ5cG1HbzZ1UUwrc0lXN0hpSXBC?=
 =?utf-8?B?VjJvS2JVUVJjTmVUZFBGaEw3VWE4OXBrM3p4ekNJbVRncjJwQzBlbHVzVUxW?=
 =?utf-8?B?RWEydXM2UHAwSDVVdngxNS95aTZmd09Sb3ZPT2FoK3MybzJzQklhMEoxZUp3?=
 =?utf-8?B?aEM5MTVYdjlMelVHRkltUlY3SXAvVXRMRDM3TFQ2Qk1iNGo0c2hXdENoNXF0?=
 =?utf-8?B?QnRweHRXWHZiN0RZRkJxaXlXVEdpbzUycllUSExMQk9tb1V6TnF1c2JqdXhR?=
 =?utf-8?B?a1c3a2F1SmNQMnVjQ281TVZBUWRuaFZKVlNiN0dlWFh3a0JiSC9zVksvQm5H?=
 =?utf-8?B?eFhwNk53dkg1d0V1QUFSUXBkdUtOR3VDZmJPcFdlclNSSkJEaEZZV0Mybjk1?=
 =?utf-8?B?QWV4RHhVc2FYWVNzQzZIR0tUTFBveUNCc2tuenFwY1lqeFpxVms2T0diZ3VF?=
 =?utf-8?B?amduUUNrbGtyS2tobWtoZEg2aW8yK1RJYmEvY2U4OE1aaUs2N051TmUzWlZ2?=
 =?utf-8?B?RGNYczNlWWJIQVh6S0M5Q3NuTDVTcjFkQXlOMkdwY1pFM3ZnVSs4cndiMTN1?=
 =?utf-8?B?bUlHTmdXZ2k5VkdqZjZadXp1MUlCd3pRc1ZIYmpTZXBwcFdDaUpRNUl2V0t3?=
 =?utf-8?B?REw0RnNoajBoSlY4dWM0NmJ5SzJSSUN1Y05odVV2cWpuYm40MS9sNXB0VjU2?=
 =?utf-8?B?eFpITXZNSndTRUZrZVNHRTV1WFFoSlJocnhsNGlhejdxYytmbmk4TlNKdmM4?=
 =?utf-8?B?RFQzY2JNUFVaK1h1YytNeHdBbDVBZVdHcTVQRFMxcDNhSWIzNEw0UVdGMi9Z?=
 =?utf-8?B?RXBCMi81VEpKZnI3QkcxOHZOaWZudmJVSzV2TGRlajBpQlEwOGJvL1FNTmJD?=
 =?utf-8?B?OTcrNEVHWUlacEN6ZGNLNnhHdEpYL2VjeVNQK1J5Zk9oSTVZOXJiUXNBdnhK?=
 =?utf-8?B?cHVGZmxhamNxeWc1SkpQSU5VbTVqWXB3OUJndUxtN1FtKzF1TnhHVW54RzFN?=
 =?utf-8?B?SE1Xdm1FQmZMNzk0NVBFQ1NDS25IckVObCtDOWIxS2o3SkM3NGJQVnNTdllk?=
 =?utf-8?B?MFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50d54c5-1075-4b08-32a2-08dabe84f1da
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 16:52:22.8603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrhzESAgsNfK0CSZxamfybfWdX1Hr15MZMckorPgw1niXP8dJs4D0X/MqCtrZI7Z3Fcv9g1OCbkjyCAjMRD9IWGKRjX8l7F35WpYmFwPYdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8184
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5v
cmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBkdC1iaW5kaW5nczogcHdtOiByemcybC1n
cHQ6IERvY3VtZW50DQo+IHJlbmVzYXMscG9lZ3MgcHJvcGVydHkNCj4gDQo+IE9uIDA0LzExLzIw
MjIgMTA6NTksIEJpanUgRGFzIHdyb3RlOg0KPiA+IFJaL0cyTCBHUFQgSVAgc3VwcG9ydHMgb3V0
cHV0IHBpbiBkaXNhYmxlIGZ1bmN0aW9uIGJ5IGRlYWQgdGltZQ0KPiBlcnJvcg0KPiA+IGFuZCBk
ZXRlY3Rpbmcgc2hvcnQtY2lyY3VpdHMgYmV0d2VlbiBvdXRwdXQgcGlucy4NCj4gPg0KPiA+IEFk
ZCBkb2N1bWVudGF0aW9uIGZvciB0aGUgb3B0aW9uYWwgcHJvcGVydHkgcmVuZXNhcyxwb2VncyB0
byBsaW5rIGENCj4gPiBwYWlyIG9mIEdQVCBJT3Mgd2l0aCBQT0VHLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0K
PiA+ICAuLi4vYmluZGluZ3MvcHdtL3JlbmVzYXMscnpnMmwtZ3B0LnlhbWwgICAgICAgfCAxOQ0K
PiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcHdtL3JlbmVzYXMscnpnMmwtZ3B0LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vcmVuZXNhcyxyemcybC1ncHQueWFtbA0KPiA+IGluZGV4
IDYyMGQ1YWU0YWUzMC4uMzJmOWRlYWU4OWU1IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vcmVuZXNhcyxyemcybC1ncHQueWFtbA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vcmVuZXNhcyxyemcybC1n
cHQueWFtbA0KPiA+IEBAIC0yNDUsNiArMjQ1LDI0IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgcmVz
ZXRzOg0KPiA+ICAgICAgbWF4SXRlbXM6IDENCj4gPg0KPiA+ICsgIHJlbmVzYXMscG9lZ3M6DQo+
ID4gKyAgICAkcmVmOiAiL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1h
cnJheSINCj4gDQo+IE5vIG5lZWQgZm9yIHF1b3Rlcy4NCj4gDQo+ID4gKyAgICBpdGVtczoNCj4g
DQo+IFlvdSBtaXNzIGhlcmUgbWF4SXRlbXMuLi4gYnV0IGlmIHlvdSBoYXZlIGp1c3Qgb25lIGl0
ZW0sIHRoZW4gYmVsb3cNCj4gIml0ZW1zIiBzaG91bGQgYmUgIiAtIGl0ZW1zIg0KPiANCj4gPiAr
ICAgICAgaXRlbXM6DQo+ID4gKyAgICAgICAgLSBkZXNjcmlwdGlvbjogcGhhbmRsZSB0byBQT0VH
IGluc3RhbmNlIHRoYXQgc2VydmVzIHRoZQ0KPiBvdXRwdXQgZGlzYWJsZQ0KPiA+ICsgICAgICAg
IC0gZGVzY3JpcHRpb246IEFuIGluZGV4IGlkZW50aWZ5aW5nIHBhaXIgb2YgR1BUIGNoYW5uZWxz
Lg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDwwPiAtIEdQVCBjaGFubmVscyAwIGFuZCAx
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgPDE+IC0gR1BUIGNoYW5uZWxzIDIgYW5kIDMN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICA8Mj4gLSBHUFQgY2hhbm5lbHMgNCBhbmQgNQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDwzPiAtIEdQVCBjaGFubmVscyA2IGFuZCA3DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgPDQ+IC0gR1BUIGNoYW5uZWxzIDggYW5kIDkNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICA8NT4gLSBHUFQgY2hhbm5lbHMgMTAgYW5kIDExDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgPDY+IC0gR1BUIGNoYW5uZWxzIDEyIGFuZCAxMw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDw3PiAtIEdQVCBjaGFubmVscyAxNCBhbmQgMTUN
Cj4gDQo+IHRoZW4gdGhpcyBjb3VsZCBiYXZlIGVudW0gb3IgbWluaW11bS9tYXhpbXVtLiBDYW4g
eW91IHRyeSBpZiB0aGVzZQ0KPiB3b3JrPw0KDQpZZXMsIGNoZWNrcyBhcmUgcGFzc2luZyB3aXRo
IGJlbG93IGNoYW5nZXMuDQpXaWxsIHNlbmQgVjIgbGF0ZXIgb25jZSBJIGdldCBmZWVkYmFjayBm
b3IgZHJpdmVyIGNoYW5nZXMvIGZyb20gb3RoZXIgcmV2aWV3ZXJzLg0KDQpyZW5lc2FzLHBvZWdz
Og0KLSAgICAkcmVmOiAiL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1h
cnJheSINCisgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRs
ZS1hcnJheQ0KICAgICBpdGVtczoNCisgICAgICBtYXhJdGVtczogOA0KICAgICAgIGl0ZW1zOg0K
ICAgICAgICAgLSBkZXNjcmlwdGlvbjogcGhhbmRsZSB0byBQT0VHIGluc3RhbmNlIHRoYXQgc2Vy
dmVzIHRoZSBvdXRwdXQgZGlzYWJsZQ0KLSAgICAgICAgLSBkZXNjcmlwdGlvbjogQW4gaW5kZXgg
aWRlbnRpZnlpbmcgcGFpciBvZiBHUFQgY2hhbm5lbHMuDQotICAgICAgICAgICAgICAgICAgICAg
ICA8MD4gLSBHUFQgY2hhbm5lbHMgMCBhbmQgMQ0KLSAgICAgICAgICAgICAgICAgICAgICAgPDE+
IC0gR1BUIGNoYW5uZWxzIDIgYW5kIDMNCi0gICAgICAgICAgICAgICAgICAgICAgIDwyPiAtIEdQ
VCBjaGFubmVscyA0IGFuZCA1DQotICAgICAgICAgICAgICAgICAgICAgICA8Mz4gLSBHUFQgY2hh
bm5lbHMgNiBhbmQgNw0KLSAgICAgICAgICAgICAgICAgICAgICAgPDQ+IC0gR1BUIGNoYW5uZWxz
IDggYW5kIDkNCi0gICAgICAgICAgICAgICAgICAgICAgIDw1PiAtIEdQVCBjaGFubmVscyAxMCBh
bmQgMTENCi0gICAgICAgICAgICAgICAgICAgICAgIDw2PiAtIEdQVCBjaGFubmVscyAxMiBhbmQg
MTMNCi0gICAgICAgICAgICAgICAgICAgICAgIDw3PiAtIEdQVCBjaGFubmVscyAxNCBhbmQgMTUN
CisgICAgICAgIC0gZW51bTogWyAwLCAxLCAyLCAzLCA0LCA1LCA2LCA3IF0NCisgICAgICAgICAg
ZGVzY3JpcHRpb246IHwNCisgICAgICAgICAgICBBbiBpbmRleCBpZGVudGlmeWluZyBwYWlyIG9m
IEdQVCBjaGFubmVscy4NCisgICAgICAgICAgICAgIDwwPiA6IEdQVCBjaGFubmVscyAwIGFuZCAx
DQorICAgICAgICAgICAgICA8MT4gOiBHUFQgY2hhbm5lbHMgMiBhbmQgMw0KKyAgICAgICAgICAg
ICAgPDI+IDogR1BUIGNoYW5uZWxzIDQgYW5kIDUNCisgICAgICAgICAgICAgIDwzPiA6IEdQVCBj
aGFubmVscyA2IGFuZCA3DQorICAgICAgICAgICAgICA8ND4gOiBHUFQgY2hhbm5lbHMgOCBhbmQg
OQ0KKyAgICAgICAgICAgICAgPDU+IDogR1BUIGNoYW5uZWxzIDEwIGFuZCAxMQ0KKyAgICAgICAg
ICAgICAgPDY+IDogR1BUIGNoYW5uZWxzIDEyIGFuZCAxMw0KKyAgICAgICAgICAgICAgPDc+IDog
R1BUIGNoYW5uZWxzIDE0IGFuZCAxNQ0KDQpDaGVlcnMsDQpCaWp1DQo=
