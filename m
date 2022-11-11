Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825F8625417
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Nov 2022 07:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiKKGu0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Nov 2022 01:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiKKGuW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Nov 2022 01:50:22 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2127.outbound.protection.outlook.com [40.107.113.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78437377E;
        Thu, 10 Nov 2022 22:50:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXoe0aiIt4F6JBo+9y7aNQGqO6RLIZTHML7HZLjE2JfuuB01S9K+wRPSUiQCfnA8EYHe//A+rQm/XJdL9CMBUyU6bOBmRq9+Gsay+Y4C9ck1yOBESLkdFitlfN719QvmDYy/5T3OxXgki86oWsgRsOcXpV8VqXKfBgG57yeDfMUzPD9hqxvhWnuZI873P3lwb0ADt/OdiA64od5Qanq6Rh5LneWenc38AyKXp3be96yiaD36dwu4Q7oen3a4oIBH8rpeQ9hLdgfpt/dTDQ1jUqeIiF3Efhf/KydGdrucM+iOpEb4LIJN+JohuXs0ldka894sNxdFrB53Pcgi9GFlaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEAb9LsVJebDFPRhdfflbmXMT8fMr4Twn6hl3FV7kgU=;
 b=n0xj1TyU5c1Sqhr9i6pGHAhoX57wy97xBjiT5cc2NTkfc2Ka2rmxWyXzfFpf8BQIJSgJ40nL1wmqTLhMEHOr4Z3p/PANuHmT0Rp1EwurPEmOZnfz2t7Lx67azHYAG4vrW4em5L7hY1HpLaANMZX231WS/o0BkJ79r64Q/JlMepDKXoYXmWX6Re+LNMsYZ63X7ijlbCnge6i9AwC1Jy7xOolI2hSgowkO0I8XW1xdUxKe/kFhEZOG0zyDOZnfU7apHaSwIeUVlzJk2f2gxhsxBKo5xLvVsiwCzNf9r6jA/hrP/PTjz/KA6sTxbQ2IN5K69f/lLfefFcYMmIIkl4Yjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEAb9LsVJebDFPRhdfflbmXMT8fMr4Twn6hl3FV7kgU=;
 b=kZSahVLbNgCtf8YzRb6eLHrONRXz2wOGQLdWWTkHQDTceQg9Jb1vkOO3r9hFIdD9ZZUXq4rTFkS5vK0bqByziE+8O6nLeniKrdk7m9LapG62Qcbx6iON+t+nO6peaTRVVIZMxa1dy0G2YaPzblLg1xjBipnM//QkAd9kO/WnD5c=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10676.jpnprd01.prod.outlook.com (2603:1096:400:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 06:50:08 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.014; Fri, 11 Nov 2022
 06:50:08 +0000
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
Thread-Index: AQHY8F4Z0M4T+LP7zUaTYMhsdADakq4u3OCAgAAdImCAAAX8AIAKUq3Q
Date:   Fri, 11 Nov 2022 06:50:08 +0000
Message-ID: <OS0PR01MB5922B6921C58A554784086F786009@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221104145938.1782464-1-biju.das.jz@bp.renesas.com>
 <20221104145938.1782464-3-biju.das.jz@bp.renesas.com>
 <dea44f32-e10f-0164-0175-4fe2e5d053a2@linaro.org>
 <OS0PR01MB5922D1D1143BB6F83A894D0E863B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <c0a6a3a1-c12d-75b4-fe1d-026ab0740b58@linaro.org>
In-Reply-To: <c0a6a3a1-c12d-75b4-fe1d-026ab0740b58@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10676:EE_
x-ms-office365-filtering-correlation-id: 8dab620d-85cf-4f20-dd81-08dac3b0f8c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4HL12w2FUErkafzkjHx/IGYybDIW8RuUYmq1F/Z7MrCMsRnVAqRqtD4OTMmQ28gDaNVA8icjX+8JvwzfNNwXWCgFq9897FA2bKctAn8DH8LQs3V/xq2CRJHCIXE1YrZtqBlaYrIJqgB+SW0V4uOtf846ydhhgaSC1mlx+BqgtRdx6bkdQLLQzIClTdomaxl7jpo4uVCdBOTLcOviJnAUQ2I4p/ZkIXcyAEYiEGRRTq6pYz+uTYoRQ4ChqqQ98tVF+sP/hb7phLqUgN0Ft4mrR0/9gpomWKp5m+C1ti1vnNzuf4AP6Q2dNgXz0Wm4oSRDggEfw36gEDXPf5ACYrnbl0qK4OIC8vuGYXZ+Y5HI8bdRflNBwul1lAp6MNeQnQunMgLbVZUVHRUsc0nwbsoyS80dSD/SnOhtPxsdmPlzfxARV4etgEUa0sUK7ZQtkUCjqgykgkGxgSDCiA/DRhCGJeElopPTyR6pVYgPwfWEexVo23pVYzJyfcVJUP+ll2ifkIxyVxHfw7+H6nWsivkFurFTxY36wwJybGUM1wCjxZMVlnZkFwEmbVEsBd3WFG36yQCCyBJvYw86X/XL6XLF/KU/exOVjRywz8lWYPWfbcfn2OUkuhk+rK230EFXB9CD/XcXFdwogfzWiVzuzi+B3FZFoE9aw9kzF3N3MPqSOZgW2X1cOZAyUtCe3pypI5DC51TOrfLKONh07geEJYma1CluU9KDCHOCQ/y9XVqCyJPtb1DoYeR3+Td/fTesFs152RaAuzaX5mj5jpxOfF8faw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(26005)(9686003)(53546011)(33656002)(38070700005)(76116006)(38100700002)(122000001)(5660300002)(110136005)(2906002)(186003)(7696005)(6506007)(86362001)(83380400001)(66476007)(52536014)(41300700001)(8936002)(8676002)(66556008)(66446008)(66946007)(4326008)(64756008)(54906003)(478600001)(316002)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHZUYlZ3K21qUktuNVZBbjNmWXc5Wjk1MUg3OGVVOUpDS2pIY3IzKzRwLzlH?=
 =?utf-8?B?cjJQNWtmd0RHZ1RxQTdsS29nSlExUDlNRmYrOG9aSmV3R1RMV0NLVzJZdWVp?=
 =?utf-8?B?cmlUM3Q4R0tXK3FGalVLb3dLc29CUTd1QWlHbkdITFB2TXhGbllkMXBjTDZT?=
 =?utf-8?B?eHJvM2wyUXhUdDJidVBzcys4QlpLbmJ3dkR0NnhQcjViTkVxUW5tYWNqbzhK?=
 =?utf-8?B?Wm9UdWpINzNwZFd0RGFoTWhkdHk1d2o0cEZqTzJ5QkdLUXJjQmRjQ2VKLzk3?=
 =?utf-8?B?cEY2KzNtU3l6d3NQRGdEYWhVdmRySERPV1hBVUlqZ0FieGpNQ2pPWWFTUHlt?=
 =?utf-8?B?WDVITmd2VmV3SkU2SG1kN09XR2h0UUYzVHE3OGdka2I2M3RSMlpvNFFENFYx?=
 =?utf-8?B?ZnRyQ0hSNkIzUW1NdjVmaVJHdU5tWnNKR21ySmRpOFJGdkNUUHVZVXpuWGRJ?=
 =?utf-8?B?a1owdGk5V21tNmtDc1lFOUY0bXBja3pHNmJRZmxuUVYrS3lyMUhFOWIxckJ4?=
 =?utf-8?B?Ky9HWjFlU29lUjA3bU04L0hLdG9iR0hVUU5XYTQzZlFKbkl1bGs1QnZyOCsr?=
 =?utf-8?B?eHJEampSRi9HZzNmUi81TkFOaHk5Q092VUpqZDJMWEZLS09PMTVJcWhZRXIw?=
 =?utf-8?B?MWlUZDkxT1RqT1BhbFhiVXk0UVIrK0IzOU5UK0xvUHZKcG9aY2IwK1FEelZN?=
 =?utf-8?B?VmlZSzgyRHY3UWY2N2VOREU0bU9Ib3NuODJ6YS9DdFk1S1NQYytVcU5PMVha?=
 =?utf-8?B?blZNVUUvamZNczdxT2lpam16a0tPMHZteGVoQ1VTcHc4elMrVFpuRitjWk9w?=
 =?utf-8?B?UGJQVHo2RGdlVGlTYVBtNzB0cXU4L2x3TGpkbGtQZk1oa1IxVnhsNlBudStt?=
 =?utf-8?B?cGR3VnVnczFPS3NDWjl0b3JKTGptemNod1daVDRkY1U4aWxwL3k5N2x2WUp4?=
 =?utf-8?B?VzQyM1JQY0lOYU5aMWlhcVA1UmNGR2t1RzVnRXZKbkFha0FrMTI4Ym5CUVVm?=
 =?utf-8?B?L1BkU1dUc0FnODRjamhYekdMTldOTEQzV2YzdjVaL3NkMXo2VEtuL09Ra1VV?=
 =?utf-8?B?eExFbDE0VysybWtmUlVjR1VLV004b2x4STcxczNXSHBhNkhpdis2c0hWeVhn?=
 =?utf-8?B?dWVGWU1kTkJXcjUvNERSWkpYaHBQQ0Q4VGJnVi91dEgyOThLQks1MHA3Tk1a?=
 =?utf-8?B?VnZ2N05kYmVydlZrdGZjNEMxSlE2aWxHZ3NTUk5GYi8zbWYyUXV2Rmp5eGtE?=
 =?utf-8?B?cUVkQUU0ellQTWczZ3c2S3BXTFRZOUMwbGtMM0JTRlhrdlZoRSsreE1vVTgz?=
 =?utf-8?B?aEJnaWZhRzkxMzhGR0x3WURXRkhudGRxQnNybms5c29rUlI2SVczTVcvckJy?=
 =?utf-8?B?QWpFajBvZGZnd2tGdHlFUzIrdzhLMkVmdXBESDdxd0owNi91YytrU1NINURv?=
 =?utf-8?B?Ujl6VWtkTXBZbnBNSWgxYjdIblRySmtLWFR4QW9Pa25CVkh3SGd0RGRZZytQ?=
 =?utf-8?B?SnY1ZVVMVEcxMHlZTVlXc1d3Z3FsMHBqbVpyRVpnWHptT3JhZDlJUVRtRnBr?=
 =?utf-8?B?aVhaTjU0YWRrRDRyMVBKUnlLSlFSeDVuVzROUC8xNUhDNHN5ODNJbXN2Z0Fy?=
 =?utf-8?B?Z1VuSjNWSGxUcytXR20zWDdyaU9DY01aUitmOHNyYU90VGs1UkdXRWR1Q1BG?=
 =?utf-8?B?d3Foa0VQMk1KWUFDUEtpVm0zS3d2MDFlTDgzNVJZTS9ySVZhVTlBRy9DQkwx?=
 =?utf-8?B?VDVKbnQyL1d2dVN1YXpJYmpLeEp4MkYzTGdkMzk0SGJpN2JJWEZtdlJDRFdG?=
 =?utf-8?B?RERid0c1ZnlGMEhIME0zUldHMitmTlZ1MTNyWmNnMjVjSDBzUXduYmJWMk9u?=
 =?utf-8?B?OHRsVU5URmJkOTN4NDVrTmNzTHpUTnE4d0pUSXNrN3pRU2RidWE4a1hPUW1h?=
 =?utf-8?B?akpkeTJwOVFrUlN1czMxS3FqZkd6Ri9BKy9welB5ZEJFaFV0MUp4ZkkyWG9X?=
 =?utf-8?B?U3luUi9rNDgrZzZxcnFrOG8vKzlVYzRVL29pRVVrRGxDR3BJeDlqZXREWFNt?=
 =?utf-8?B?U2xER2pnbUwwNEVxb0pxWklXYjduUElaSnFKM0JhYTZORnJmUW1TRGJiMlh0?=
 =?utf-8?B?SGtFcmhSU2lDSDltS2xiR0Job2ltbWRDc3R3alF5SmpIemJ3d09tSU5hSWZx?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dab620d-85cf-4f20-dd81-08dac3b0f8c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 06:50:08.1058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yc/9LChaIHEZtOhNwkhQ52XJPhSMqIlJBvdQrLAqCSF71LPE33ZQnXewLFs5GX9FFbIjXksJtqLrwqzXAFLB63nzbljBkU7b8U/n7Pzg2Dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10676
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
cmc+DQo+IFNlbnQ6IDA0IE5vdmVtYmVyIDIwMjIgMTc6MTENCj4gVG86IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT47IFRoaWVycnkgUmVkaW5nDQo+IDx0aGllcnJ5LnJlZGlu
Z0BnbWFpbC5jb20+OyBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgS3J6eXN6dG9m
DQo+IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPg0KPiBDYzog
VXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT47IGxpbnV4
LQ0KPiBwd21Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgR2Vl
cnQgVXl0dGVyaG9ldmVuDQo+IDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT47IENocmlzIFBhdGVy
c29uIDxDaHJpcy5QYXRlcnNvbjJAcmVuZXNhcy5jb20+Ow0KPiBQcmFiaGFrYXIgTWFoYWRldiBM
YWQgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT47IGxpbnV4LQ0KPiBy
ZW5lc2FzLXNvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGR0
LWJpbmRpbmdzOiBwd206IHJ6ZzJsLWdwdDogRG9jdW1lbnQgcmVuZXNhcyxwb2Vncw0KPiBwcm9w
ZXJ0eQ0KPiANCj4gT24gMDQvMTEvMjAyMiAxMjo1MiwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkg
S3J6eXN6dG9mIEtvemxvd3NraSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxp
bmFyby5vcmc+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8zXSBkdC1iaW5kaW5nczogcHdt
OiByemcybC1ncHQ6IERvY3VtZW50DQo+ID4+IHJlbmVzYXMscG9lZ3MgcHJvcGVydHkNCj4gPj4N
Cj4gPj4gT24gMDQvMTEvMjAyMiAxMDo1OSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4+PiBSWi9HMkwg
R1BUIElQIHN1cHBvcnRzIG91dHB1dCBwaW4gZGlzYWJsZSBmdW5jdGlvbiBieSBkZWFkIHRpbWUN
Cj4gPj4gZXJyb3INCj4gPj4+IGFuZCBkZXRlY3Rpbmcgc2hvcnQtY2lyY3VpdHMgYmV0d2VlbiBv
dXRwdXQgcGlucy4NCj4gPj4+DQo+ID4+PiBBZGQgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIG9wdGlv
bmFsIHByb3BlcnR5IHJlbmVzYXMscG9lZ3MgdG8gbGluayBhDQo+ID4+PiBwYWlyIG9mIEdQVCBJ
T3Mgd2l0aCBQT0VHLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEJpanUgRGFzIDxiaWp1
LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIC4uLi9iaW5kaW5ncy9w
d20vcmVuZXNhcyxyemcybC1ncHQueWFtbCAgICAgICB8IDE5DQo+ID4+ICsrKysrKysrKysrKysr
KysrKysNCj4gPj4+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4NCj4g
Pj4+IGRpZmYgLS1naXQNCj4gPj4+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3B3bS9yZW5lc2FzLHJ6ZzJsLWdwdC55YW1sDQo+ID4+PiBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9wd20vcmVuZXNhcyxyemcybC1ncHQueWFtbA0KPiA+Pj4gaW5kZXggNjIw
ZDVhZTRhZTMwLi4zMmY5ZGVhZTg5ZTUgMTAwNjQ0DQo+ID4+PiAtLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcHdtL3JlbmVzYXMscnpnMmwtZ3B0LnlhbWwNCj4gPj4+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vcmVuZXNhcyxyemcybC1n
cHQueWFtbA0KPiA+Pj4gQEAgLTI0NSw2ICsyNDUsMjQgQEAgcHJvcGVydGllczoNCj4gPj4+ICAg
IHJlc2V0czoNCj4gPj4+ICAgICAgbWF4SXRlbXM6IDENCj4gPj4+DQo+ID4+PiArICByZW5lc2Fz
LHBvZWdzOg0KPiA+Pj4gKyAgICAkcmVmOiAiL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlv
bnMvcGhhbmRsZS1hcnJheSINCj4gPj4NCj4gPj4gTm8gbmVlZCBmb3IgcXVvdGVzLg0KPiA+Pg0K
PiA+Pj4gKyAgICBpdGVtczoNCj4gPj4NCj4gPj4gWW91IG1pc3MgaGVyZSBtYXhJdGVtcy4uLiBi
dXQgaWYgeW91IGhhdmUganVzdCBvbmUgaXRlbSwgdGhlbiBiZWxvdw0KPiA+PiAiaXRlbXMiIHNo
b3VsZCBiZSAiIC0gaXRlbXMiDQo+ID4+DQo+ID4+PiArICAgICAgaXRlbXM6DQo+ID4+PiArICAg
ICAgICAtIGRlc2NyaXB0aW9uOiBwaGFuZGxlIHRvIFBPRUcgaW5zdGFuY2UgdGhhdCBzZXJ2ZXMg
dGhlDQo+ID4+IG91dHB1dCBkaXNhYmxlDQo+ID4+PiArICAgICAgICAtIGRlc2NyaXB0aW9uOiBB
biBpbmRleCBpZGVudGlmeWluZyBwYWlyIG9mIEdQVCBjaGFubmVscy4NCj4gPj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgIDwwPiAtIEdQVCBjaGFubmVscyAwIGFuZCAxDQo+ID4+PiArICAgICAg
ICAgICAgICAgICAgICAgICA8MT4gLSBHUFQgY2hhbm5lbHMgMiBhbmQgMw0KPiA+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgPDI+IC0gR1BUIGNoYW5uZWxzIDQgYW5kIDUNCj4gPj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIDwzPiAtIEdQVCBjaGFubmVscyA2IGFuZCA3DQo+ID4+PiArICAg
ICAgICAgICAgICAgICAgICAgICA8ND4gLSBHUFQgY2hhbm5lbHMgOCBhbmQgOQ0KPiA+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgPDU+IC0gR1BUIGNoYW5uZWxzIDEwIGFuZCAxMQ0KPiA+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgPDY+IC0gR1BUIGNoYW5uZWxzIDEyIGFuZCAxMw0KPiA+
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgPDc+IC0gR1BUIGNoYW5uZWxzIDE0IGFuZCAxNQ0K
PiA+Pg0KPiA+PiB0aGVuIHRoaXMgY291bGQgYmF2ZSBlbnVtIG9yIG1pbmltdW0vbWF4aW11bS4g
Q2FuIHlvdSB0cnkgaWYgdGhlc2UNCj4gPj4gd29yaz8NCj4gPg0KPiA+IFllcywgY2hlY2tzIGFy
ZSBwYXNzaW5nIHdpdGggYmVsb3cgY2hhbmdlcy4NCj4gPiBXaWxsIHNlbmQgVjIgbGF0ZXIgb25j
ZSBJIGdldCBmZWVkYmFjayBmb3IgZHJpdmVyIGNoYW5nZXMvIGZyb20gb3RoZXINCj4gcmV2aWV3
ZXJzLg0KPiA+DQo+ID4gcmVuZXNhcyxwb2VnczoNCj4gPiAtICAgICRyZWY6ICIvc2NoZW1hcy90
eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5Ig0KPiA+ICsgICAgJHJlZjogL3Nj
aGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheQ0KPiA+ICAgICAgaXRl
bXM6DQo+ID4gKyAgICAgIG1heEl0ZW1zOiA4DQo+IA0KPiBhbmQgaXQgbWlnaHQgYWxzbyByZXF1
aXJlIG1pbkl0ZW1zOiAxDQoNCk9LIHdpbGwgc2VuZCBWMiB3aXRoIHRoZXNlIGNoYW5nZXMuDQoN
CkNoZWVycywNCkJpanUNCg==
