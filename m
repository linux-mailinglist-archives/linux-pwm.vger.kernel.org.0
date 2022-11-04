Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8445619C4C
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Nov 2022 16:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiKDP6V (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Nov 2022 11:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiKDP6R (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Nov 2022 11:58:17 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2139.outbound.protection.outlook.com [40.107.113.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB5432B9D;
        Fri,  4 Nov 2022 08:58:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JABcol6gbxN3kegF8FB3h1q46C5D8NXXaoEArcMzvLxyz6HdD3Vg7LxhnIVBDsImzBUz+jGE8HH3HhYbMxb0QOTTKufkpjNl3wEdh2ZS1tGTjUgWTOVJUaKr3VartprnC8K41uXktnNaDAk7UaXKauUmjWia+N8gPSyaxPEm1bzoCheTIOvr1zwqnj/um2I1JmAfEPIfK2FsHWmPyAGk9edB/kI5YUibBsQfw21csG2N3WRbEp4oGWqaqz6sVfH4ZfyS5+HIVhIkX3xVnv11wDP4UIc+uM+Q066JozP6fRIsYDMcLtrmVTnfCUbAeqxRIFHRAkEk8KdyHJhKKTUm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DqAcRVS2MFaQh2ArWdz+FT7M1zV3rnpORRhrtwIdtk=;
 b=HAHBIQm6GGHQQUrmIOR7mvF/fv5PpGk7GU9iteG0cCdLUHftg8xo0/4rpufIbthalWsxtayMdp/a9oj4aUksSp+bs8/0PVZsQSpISVn8Fc6cR0nIzOqkXYwfz7VGGTw8GvM08h+Nk7AEdcwql6WnuPOis8GW0rCdHgkY6dLf9Se92JzPM6JDDS9wqdImPl7EQBYDRPyhzs9LbmGqShbMrZLmrojR5rqoOF4zFcBEmzxgjsCEcX+G8m7haGomrTVukx75IQJ7OzT2TGnvJN2iY4g83gjXkZNAOTpdjWoQ1kJ2MRlGDEMjwsSyVxnbD+JkBgDa4SP+R+9OyvQlU/PK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3DqAcRVS2MFaQh2ArWdz+FT7M1zV3rnpORRhrtwIdtk=;
 b=rU14rwwZwLk1COE6EWzRVAZ6PJ2j7q9HNLVnXHMqcZEonKAFKCpK5NgKecs9N3/iKMC3CFs+Di5JZHsRAulQwPLaTZs6feB5+YHgxaEtLEapL+lGr/NxUUs/iXDqQCAHQ06vOe2BL/egAC59Y8+NpXt94VJzrkChy4EXw24An8s=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB6125.jpnprd01.prod.outlook.com (2603:1096:400:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 15:58:07 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5791.023; Fri, 4 Nov 2022
 15:58:07 +0000
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
        <linux-renesas-soc@vger.kernel.org>, Rob Herring <robh@kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: pwm: Add RZ/G2L GPT binding
Thread-Topic: [PATCH 1/3] dt-bindings: pwm: Add RZ/G2L GPT binding
Thread-Index: AQHY8F4W6QtlfGi21UK7IFsTurdwza4u3EWAgAAPQqA=
Date:   Fri, 4 Nov 2022 15:58:07 +0000
Message-ID: <OS0PR01MB5922FE4D4D9B81B3366B3E92863B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221104145938.1782464-1-biju.das.jz@bp.renesas.com>
 <20221104145938.1782464-2-biju.das.jz@bp.renesas.com>
 <dc6b70bc-c82d-9540-5cb7-e7a249359a78@linaro.org>
In-Reply-To: <dc6b70bc-c82d-9540-5cb7-e7a249359a78@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB6125:EE_
x-ms-office365-filtering-correlation-id: a89b4a4d-9f17-46cf-ddcb-08dabe7d5d69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qFfDlyrT/So1AvzM2UjlkpQrvQaRabB8N91bZYTRlwyAYKtNMAHoqv4pGUzPeaIDapf5TR32ch0ALba3FDBOXqiXYv669bJDDKEIgGOfvEKA5sIl1CjPEjK70BbRMdpp/M5aUSg4A8FYkCmL5b8tcPX6iY4SmOIP7ZwAME6ToZXRdXE/X47t9lg09JVgbSD3igZfKakNazsQMxG+3Au+iLUF75tgaCgDRdf4WVSVaddCWVzjGKIARCTvPvXbFcCR7b1M7ja4Z9/964eWkCV+PZOx2tZZ48fUO1TFltbhvseo33glVTA53P8w1YW07RsOvqE79rwl8XwhUmcfygoEgBiO2ZF/57R5KZDlScuuQFcfN6G6UJLJ01ZE3vsgB9bGlBYxxQ8wNCPA/SB8kO5+a8GZ5H0N1TGdvzAeDUT1bIV90lRqkauEqSTN6x+bEsjVahe1Qyq2YlPEfp4MtNtq+t974H16AqDRWHDNvMvnYXl96UaekVgQLVKGDxMhTod+HfjSAv/F/yQrhp+cm9SMrTAmh+QpI9ajCw09t8i9inPEDfz13S/M2/tsieLwq7+AfQYSGrdDJOaa9gtj29ojcuVTHCvR636rgi07rupIZTvyV3s8iDS82Y7sWG4fMA6ihAM/Y9P5t+H1HB/G58DNpSH/5p5EXx7VSQqIvxR5t214bed8hhoPgNGQfOE6Mx9HS/aDM1UWq53rZsP+YBC/Adf1gQUDTp67dCvUW5obA7phW2mbYQJQ0ghrGpRZrQSHsx7roqLlrfm4uVuuPDZYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(33656002)(38100700002)(86362001)(38070700005)(4744005)(55016003)(2906002)(53546011)(9686003)(122000001)(186003)(6506007)(7696005)(26005)(66476007)(66556008)(66446008)(64756008)(478600001)(76116006)(5660300002)(7416002)(8936002)(8676002)(66946007)(316002)(110136005)(4326008)(52536014)(71200400001)(41300700001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXlqUnJ5dEo5bXN3dmhpTThZRnVNKy9qQXk1SDF6OEtGV0ptL3JhMForOEE2?=
 =?utf-8?B?Y3JqcVRvNjlRbWRHRFJ6UGxBdFFLenpkS2RrSDAyUDZ0N3ZERk5WNHBpTitD?=
 =?utf-8?B?YnNCc1M5WEFLQTlYVkxvcHdZUEdTcndCcU1yR0JxUENzMnVRenBWODJnZ1dq?=
 =?utf-8?B?OStSTTlDNGVYSjh0RmpFZVBzUmlzS3M3NEtodzZuek9zWXhTN2xIZ1J0SUF0?=
 =?utf-8?B?TzhwTHIrZldmTWFBNC8rV1NrdzFPdisrYnNCNWdwZEoyb1QybHo3TDlQbU4w?=
 =?utf-8?B?dVpLNm1DNnJpcjJXRGVCdUpISWxzeTdHK0lLUW5SZ2FDaDVPYWxaZCt6UXk0?=
 =?utf-8?B?T1ovd2hyZVoweEo1VlVlZkhCd2tjMU9PVjlPcitqYWR2Rmc0UE1uMHhFbUI3?=
 =?utf-8?B?TDZzVlFESHBSUC9ycFAxTjlhWTJJZWpzbXBwd0J5U1d4YzVhcndROHlpd2xR?=
 =?utf-8?B?Ny9HU0pMTUZhOTIxQkdYcjYvM1pRMXAyQVZxeWlxOFkzWWtJRWVzZEdFcC80?=
 =?utf-8?B?SUtGQmNtdzJWSWNhN3VzOE1pY3llc3p2Y0tnZ2c5bUxCQXYwV1RYZjl0dUpF?=
 =?utf-8?B?R0FwdXhqU3c2bjJyU2JQMDBoR1VKa3pvSm8zbncvWmNka21KelBjamt4WHlV?=
 =?utf-8?B?ZzM5VitzMjNoVFQ1VmxaZng0MWIvNkxGejJ6SHpXUURITU5JRW5WbXI4Y1dn?=
 =?utf-8?B?NzRFSkF1bGMwZUVkeGtsc0hUNk0yR0dIM0JqNmVkTkdTSjJKRmxQOGQ3K3NI?=
 =?utf-8?B?N21iUFBqRlVFRUtEMkYyRjNIc3BJTkJTdHlLbXhIU0JSdXJSRmZPYy9TOHJa?=
 =?utf-8?B?ZkxlMFBmbUNrZS9TUGt1b004djNkWXdWUTN0Tkt3VzhBVkdzZkc4eDNxS3pK?=
 =?utf-8?B?VTVHcnF6MTFpbll5SzA2TjVFSG9YUk9JR2QyS2ZyS1lFbEYvNWpncCs0WE80?=
 =?utf-8?B?TW1RV2szTk5HRUY3UllRRXhWMFFtTlZxOHJmTzRxTUNxcGxOK1JTQXN2eG1G?=
 =?utf-8?B?UCtON3hOOEtuK3RSVlNoeEk4SkJPZ1dqdzI3OVBIeTZnWHpRUVJPeXNSKzUz?=
 =?utf-8?B?UWJoM3NyYWpxTnZURFBzbWlkMTlia1BncXZLb1RmK1E1dEkwc2puZFEyQmRM?=
 =?utf-8?B?d3JscmhDbm9kamJLZ2c5aDJncVN5a3o5UDRYZWgxL3kwWEJIZktlQUQvL1ZE?=
 =?utf-8?B?d1BQUjRMUFFadnRqTmx0cVcyVUdjdVBieERHM2h3bWI3WTAybHFOeTg0elVY?=
 =?utf-8?B?N1JJUEhkWGhYWEhrblJZTEZFbnlWVjhBR3RURGFwYTRWYjFZRWFmc1pEOHY4?=
 =?utf-8?B?S2FtS2haN0FhMitCaWxBeDhoM2RqUDlOY24xcFhoTzFFTTR5elhxQUg1MzRn?=
 =?utf-8?B?UDlCMjhldmhicGllZWdNQWplREJCaS96Z2Z5dzVlakc2VFJaK1hDZ2pmcElj?=
 =?utf-8?B?OU56YUp6TXduQVZ4ZGh5OEY3Tm0xYUQ0aUtBaHMyaXhrL1Nrd2hpWXZwakxU?=
 =?utf-8?B?eGNIcWNqaUl6SmNmUEw3aEFRRlpMR1dCS0VtVHp4T3RWSzVrWEx5a2RrcURE?=
 =?utf-8?B?Um5GUGprTi9tanJlNmVGSEVsaXNlayswNi9xRFZwVmYya1hBYlJwajFMQndr?=
 =?utf-8?B?MUUwUjI1SVJPOUxrWFUzbWRRUG15dUNkUmVsQVR1SVl4V295dXBqOTU3cDZI?=
 =?utf-8?B?ajAyMStINjVYdlh6b0I5VWNQZ2IvNWJUM0lVZHNPVE5jcjZXa1l0V0FNdHho?=
 =?utf-8?B?eVI2YXNydUlYSG5GTk1oUkU2cVhmSi9xcnUxUjVxZGVqc0VpMmkxVDVJV0p2?=
 =?utf-8?B?dnhYMnlmYzh3Y2gwdWpMdUE3cTRxMUFyaGhFUXJpTzVmOEhsTWdXODRCdHJP?=
 =?utf-8?B?ZGE3WWg4Tzg5RkNvMVkyeGI4VmRTOXk2eHlabGhveVd0RVREcFQrdGlYWk5V?=
 =?utf-8?B?bFc1VUlncjlRY0hwTDVxRnpBMW5MNEFNdVowcExIVjFXRkZMYUwzTWVUbngv?=
 =?utf-8?B?bGYwa1JkVFpndC9kbTZwM1RGWDlzcXFhaU9ydUpib2lwcUJrcnhpNkw3c0tS?=
 =?utf-8?B?bDcvTkE2aE5ib04vc3ZwU3dxblo3TGY0MEQ3c0VXQkxsNlRpdUF3b3Q4NDdG?=
 =?utf-8?B?Zk5EZUpCL2dCdk5VM2Z5Qk9GMEVwcTVLNjhNcGpXbm85dVMxOU5yNUN0Z2k0?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89b4a4d-9f17-46cf-ddcb-08dabe7d5d69
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 15:58:07.3598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+QWtsuoU8n2pBckRk2OsXWn3dE8/ggTiM75I/dGQoobraggMVwODnc6E61gVUaVyMpeyw/4zYj1p8DEjjCZebM6B0jFZwMgj8XVdIBDu50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIGR0LWJpbmRpbmdzOiBwd206IEFkZCBSWi9HMkwgR1BU
IGJpbmRpbmcNCj4gDQo+IE9uIDA0LzExLzIwMjIgMTA6NTksIEJpanUgRGFzIHdyb3RlOg0KPiA+
IEFkZCBkZXZpY2UgdHJlZSBiaW5kaW5ncyBmb3IgdGhlIEdlbmVyYWwgUFdNIFRpbWVyIChHUFQp
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVz
YXMuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0K
PiA+IC0tLQ0KPiA+ICBzZW5kaW5nIHRvIGF2b2lkIGJvdCBlcnJvciBmb3IgdGhlIG5leHQgcGF0
Y2guDQo+IA0KPiBUaGVuIHN1YmplY3QgbWF5YmU6DQo+IFtETyBOT1QgQVBQTFkgUEFUQ0ggMS8z
XQ0KPiA/DQoNCk9LLiBXaWxsIHRha2UgY2FyZSBuZXh0IHRpbWUuDQoNCkNoZWVycywNCkJpanUN
Cg==
