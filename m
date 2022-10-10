Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF175F9F00
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Oct 2022 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJJNAJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Oct 2022 09:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJJNAH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Oct 2022 09:00:07 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2118.outbound.protection.outlook.com [40.107.114.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753F61583F;
        Mon, 10 Oct 2022 06:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwK4X3vmSp2cyha9H8aospEoP/4SWPIS871e9IBUCWmM/kMGWGDA5N66lODW5FFDnYOWVismhIngJndC3IeOfd+0HmnvUC9WOfEyGXWGxFiQgShHvqHnZP67tZquYra35lO2yoVESDqWVOEaOv00TxIyifElBKPFdbvUIkXPFBzFf+byEkODlIINaNIK/lJCILCQZdWULcFTcV4Y8xXjXMNT59m2UJmVcfHd+uUkNQhWdrLgos8csE4fL6AoydWDGYbHpVE0h/tg/gLXs2F9AKK/H0VhhL7pYwRRymhx26+anaCizyDpxnYjV7W+YBpK2OATMUt9m3ZHYv6Oi+GC8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxFfmLWO11BR20YJF0t1A+/oVlfyyBU76sw5waYox30=;
 b=Bg01Lx371LE983eAGZ+LBQGX4XX4hwbBsZAuRTORQe2v2eOzolwyHY03aOtBYxWmCzGffS1ybAJbgVekaDxnyngRUkec1NTynyNISaS1i90Eq7atHirpf+MRlfmp5Jc52hEp6f/k5fOb9cEqhNfNd/vxv4YmVzvA0+a+0nhrv3dxRi3RIXUHtqa7RH3tWf4LUUpiWcLtur3D++sRA9qL0uuIX/utZh8amcLjsWkXqPwJPEyJ78hAurEDGRi7hCL1SB9cJwYGdOd03sy462e8i6hfnG8zjljlZvJoOoCM7ryOs4SzYWAk5QAoMT2cFABB5JMUcpVComMpcNcOJUla4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxFfmLWO11BR20YJF0t1A+/oVlfyyBU76sw5waYox30=;
 b=gyqZUo5o4RDib2Es2Sj8qUvQXhG1aMaiyzzscYmC1debPfMcLIoOvV/+0Ur9mHVsVTkAMO7RRm3Wc8XMgUDGhJezfQIN6dJTxBxeFiBgpQmdTY5DgklZdFchda6ZGKYXPuRsxo6vIkMfQw5Ibb4wX680Kj8mi3fVv5ch+/4g+ko=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYAPR01MB5882.jpnprd01.prod.outlook.com (2603:1096:404:8054::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 13:00:02 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%9]) with mapi id 15.20.5709.015; Mon, 10 Oct 2022
 13:00:02 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Rob Herring <robh@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Topic: [PATCH v3 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Index: AQHY2YuXPmW6g+v5akyG0CoeRXz0kq4Bzk0AgAEPNNCAAT9J8IACCdiAgAAKuoCAAWuAQA==
Date:   Mon, 10 Oct 2022 13:00:02 +0000
Message-ID: <OS0PR01MB59229650F0BD26FBF2FB1E5D86209@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221006135717.1748560-1-biju.das.jz@bp.renesas.com>
 <20221006135717.1748560-2-biju.das.jz@bp.renesas.com>
 <20221006201746.GA93297-robh@kernel.org>
 <OS0PR01MB5922F8058FC8FD1E35C17755865F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59221BDEB7E6B39AEFD31C44865E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWmT7+8ow4-P-gbPb6gt221B51RN3vGXafmpeVwi4rbkA@mail.gmail.com>
 <2961c272-52af-9f77-0ff3-105b81438316@linaro.org>
In-Reply-To: <2961c272-52af-9f77-0ff3-105b81438316@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYAPR01MB5882:EE_
x-ms-office365-filtering-correlation-id: bda6dfe4-7f21-46c2-3c87-08daaabf5848
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sQw/eEcBStFp7tZYhKQc0Dv0TMDxebPS3pJRcCd/pbcSVlmil8K+2weah6Vx90K1osXlHQNzANbSZNXjOn7lZA+ESJl6A8XeL0HAUYkRkfz05bleLOYC3tz514aTwK/tXdiFv3KwFIvcg9hRzHj38DFvwHwBzExcfWOxFJVloTd3sqym2/QdnqrfKPoEaOEJQo9R7TSyF5OXaObypHwJq5Dbu6s0vT1NZNnd+FWfyj2LHciTtMIKBmOxDQkRymz7HEoXgNNz732NSLhjstcPJ2M9bI4rdeOmBycJJ5JBdVVkHoTxpb2NhjEhuX8mKSQZt/nu1g1mf5zxQP0WvleovoovU26MljusVcpXRzwjg3DfgwGT0X1cg5ahws26qsvaiVamwwTi1RpMnqvigfMXS0OZ6rUMe+o0A8Le1rvSIaXFOUUoM6WwjiH8hJUawmrjOEbogbQRR4lnOp/YGoFYqENBQxBKMc19pNJGJLygVx4lpjrOQuEPOxPBqH2BE3LnmhIjrsUCOTXfYQgd4wW9VNUFDyWnVXH0VjuuhwISNEtHTxizmY6PmySr7rB8iX+vOGXBMnVZLCLxXxseZeprtw4BL9NPfwRX5UrmNspErjw24Gm8NE4SWYvE3xpAXXAL04QI6APihiX5i8JHCviw3sk5HtbbJL25uH0Uvbz3ooMxfWaZX5bbYRdOkcPKtUK4jtFzOXFqjIbqB9wmPIWhNdeYDffHMZ1Z/7hZdqJIi9tFoeLf/ecP6AbbuA9qDamK5ZgHOnFdIPjUHNtE3Ys/wz2M7sGeQZGx+tnvN02Vswc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199015)(86362001)(2906002)(478600001)(186003)(53546011)(26005)(6506007)(7696005)(9686003)(83380400001)(54906003)(38070700005)(110136005)(38100700002)(122000001)(7416002)(71200400001)(5660300002)(52536014)(8936002)(316002)(41300700001)(76116006)(64756008)(66946007)(66476007)(66446008)(8676002)(4326008)(66556008)(55016003)(33656002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ny9vcmhlT0xkY0svSEdEdHl0T0crZEtsZXJoWVpMYjgwZUdEbS9NcCtxOVZQ?=
 =?utf-8?B?OXFyTkxGRWIrWGdJMlFla3RDOHRvaDJXazIrRUhQVmQ2U0l2VHRrczY3eFRh?=
 =?utf-8?B?NVJRbHd5bU55cy9reHAwTUxTS0U5VlovdGRZVllSWGxpRlg4Z3RkTmN3aGt1?=
 =?utf-8?B?QUI1RUFvM0R5cFdOaEtkWkx4bllzSVBYSDV3K1ZVN2FuSElQN21MUmhKR01t?=
 =?utf-8?B?Y3VDSytlMkxBbVl4YTFLMm5kb2RkRFZBdktTbC8raUtWb3lKcjVaYWw2WlBP?=
 =?utf-8?B?aS9DVkhWVlZWWWRaaDlnZ1ByeDJFdUhJZ2E4dWFoQlBIeWY5MmY0L1Q4TkpM?=
 =?utf-8?B?SzZRYUdxM1BQZS80d1I3WVFVSDdTM3U2dm5wQ3pPbjdZaktUWW1oU1ZOOFlN?=
 =?utf-8?B?RGsrcWt2K2dzSndoS3JTWHZPSHlBU3RmbnM4cTdLTGZMZTZmRnFuTVRRSGUr?=
 =?utf-8?B?Nzg4U1IrWVdBVmRWbjZNemwxU01jOTV1S1ZtQ2tUQTlTSzNVZE85UnpNMHVQ?=
 =?utf-8?B?YStoRmZlUFlFSEVzSTRqenJrUHNRaUVaYTRncHEyRFRoNFl0ZXVrcFdSUmtz?=
 =?utf-8?B?TEJUdU5aVWkvbEFjMzFOK3p5dktXWDZna2hvczFXUU5SWW00RUY4LzVtRndw?=
 =?utf-8?B?Rm9RcGVHM0poSFNnbG0xakQrVldFWHBpaWZFb2ZTbHdoRDdwdTk5YzR4dDZR?=
 =?utf-8?B?Tjdud2tPbmlqOWtzQThXcTFCeEIvWmlwd3F3azM2RkJqcC9RbFNOSG5XVDls?=
 =?utf-8?B?d1VYUjhXTEJ3Q1ZpaHZIRUROSnpHRWFoSlFkN3RPNUtIOFRpYzFWd2p5TlJa?=
 =?utf-8?B?b2U1ak5rYjNKK0F3T29Fa0Q1TGUyYmFzei9jTlFzYjVWaFoxbW9yRS8rNVoz?=
 =?utf-8?B?L3hYWnFmekdlNVZqQ1R3MGdVb0Q0eDlFeEZBd21URCsxNlBZWHM4ZVhUT2dL?=
 =?utf-8?B?dmZtcG9BdVoxc2JwMDhnZ1JUblU0MjhDNkdJWmp0aDVBYXpUNlg0Wm1KYy93?=
 =?utf-8?B?K1AwYmlPKzFVNzdzbXdxZ0VLMWY2RlkrSnVLd1RGRmtwanJkN0xDMXc1OGl6?=
 =?utf-8?B?OFcxem1MMUZiK3NJWFVBdm1hL2JZd2RnUTZJdlBFRmpKL3A5ak9kNmlVME5C?=
 =?utf-8?B?OWY1bEVTUGtPSGUxUWZMemFmVWJwZGhjNVpLT0RFRU1QaUxrKzZneEI2WEhr?=
 =?utf-8?B?bXFFK0swV3lqdTFIc3d1aTlTSVNPU2ZsUXovV1Jya1JSY2kxSnBJaDZ0MkdO?=
 =?utf-8?B?MTVTNmVjVy91Y2czamFlQ255QVhvTEMyOVNmMXA0blkxNjBpampGNUdsVFJy?=
 =?utf-8?B?K2VFcDkzdDZlSHB4a2h5ejE3WGloTUJlZVVTS09neHBoeG1na2VWb0VTSTBL?=
 =?utf-8?B?WEtBL1QzQ2pYWWJUcnZmYk1iNHRYV2tYdFFyRjBJYUh0N1NyeW81cmk5TW1w?=
 =?utf-8?B?dFRZTWYxWE91ZFRTbFBCNWkwR1Q1S3VlZmJBVXhsYXBaNUVocDJQdnZNdklF?=
 =?utf-8?B?VDBUOWo2YWUxNHgxTnRYejVmeGlkamhETzRJZ25DdmtTWmxEMkR1OU5RbENj?=
 =?utf-8?B?M3F3S3M4UUptYnRrdzlRVWJ6RENUb3hWT21xSGpYZHR0UVpabVlFU1FrR2Vp?=
 =?utf-8?B?eTVtM25uTTdPY2RRYmNkK21oTlJqeEd6OStUNDBxUCtSTmZ5V3pkYjl1NHNB?=
 =?utf-8?B?YnJxNnlpN1VMWE1tZ0lQeFgzTTNCdjYvTE1adjVLdHFrRVRMaTc4L3EvSVNC?=
 =?utf-8?B?Z3pKTGhPakdhcXIxQXVDUldtbDA3TGZPUUpoN3hUR2xsWGYybDI0K1RtVVZQ?=
 =?utf-8?B?S0ZUNEVJQzk3VmlrSmVsdjNySzdpenFiOHZPRlR2VDBxVkwyL0FmbXFLcFg3?=
 =?utf-8?B?cTR3Vk54VkwwWkMzQVFUVTFOd0NsWk1hR2FTMDNZaW5NdnRYMGY4SVEyT2gv?=
 =?utf-8?B?QzROS2tLa1l0d2ErVTlhNlMxVVlqMDV4cTlzSUdHMEtVdW04Q3VPTlBpb3RT?=
 =?utf-8?B?RVRYT3pURnN1TUJjTWNvMTJFc3Y5L3UwbXd4Ti8zaXR5T2IwQlUwVmJ5bWFy?=
 =?utf-8?B?WDB6NjBnUDBwVlZiRjcrN1J6WGw1TXg1cG0rck1JVVJZcTRJOWx6TXJpaUl4?=
 =?utf-8?B?K3J4dm1JbjQza25oMjRaaDg5Qll0M2E1dGRFNVlaNFREVDU0UGE5cFViMmdh?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda6dfe4-7f21-46c2-3c87-08daaabf5848
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2022 13:00:02.2482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dd7aNP9qmDLUf+vYoIM+BabcYhPp/rRamudgoEwxiTMj4211gG/TA/zW1nGvRCvhE0EA1Pc4X6yKzGps+bZj7+mfLvThok+sr6g3+C+Uf2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5882
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgS3J6eXN6dG9mIEtvemxvd3NraSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzRdIGR0LWJpbmRpbmdzOiBtZmQ6IERvY3VtZW50IFJa
L0cyTCBNVFUzYQ0KPiBiaW5kaW5ncw0KPiANCj4gT24gMDkvMTAvMjAyMiAxNjozOCwgR2VlcnQg
VXl0dGVyaG9ldmVuIHdyb3RlOg0KPiA+Pg0KPiA+PiBTbyBsb29rcyBsaWtlIGVpdGhlciB3ZSBu
ZWVkIHRvIHVzZSBjb21wYXRpYmxlDQo+ID4+ICJyZW5lc2FzLHJ6LW10dTMtY291bnRlciIgYW5k
ICJyZW5lc2FzLHJ6LW10dTMtcHdtIiBpZiB0aGVzZQ0KPiA+PiBmdW5jdGlvbmFsaXRpZXMgdG8g
YmUgaW4gcmVzcGVjdGl2ZSBzdWJzeXN0ZW0gdHJlZQ0KPiA+Pg0KPiA+PiBvcg0KPiA+Pg0KPiA+
PiBzcXVhc2ggY291bnRlciBhbmQgcHdtIGZ1bmN0aW9uYWxpdGllcyB0byBNRkQgc3Vic3lzdGVt
Lg0KPiA+Pg0KPiA+PiBQbGVhc2Ugc2hhcmUgeW91ciB2aWV3cyBvbiB0aGlzLiBJcyB0aGVyZSBh
bnkgYmV0dGVyIHdheSB0byBoYW5kbGUNCj4gdGhpcz8NCj4gPg0KPiA+IEkgdGhpbmsgd2hhdCBS
b2IgbWVhbnMgaXMgdGhhdCB5b3UgY2FuIGhhdmUgYSBzaW5nbGUgZHJpdmVyIHRoYXQNCj4gYmlu
ZHMNCj4gPiBhZ2FpbnN0ICJyZW5lc2FzLHJ6LW10dTMiLCBhbmQgcmVnaXN0ZXJzIGJvdGggdGhl
IGNvdW50ZXIgYW5kIHRoZQ0KPiBwd20NCj4gPiBmdW5jdGlvbmFsaXRpZXMuIEp1c3QgbGlrZSB0
aGUgY2xvY2sgZHJpdmVyLCB3aGljaCByZWdpc3RlcnMgY2xvY2ssDQo+ID4gcmVzZXQsIGFuZCBQ
TSBEb21haW4gZnVuY3Rpb25hbGl0aWVzLiAgSS5lLiBubyBtZmQgd291bGQgYmUgaW52b2x2ZWQN
Cj4gPiBhbnltb3JlLg0KPiA+IFlvdSBjYW4gc3RpbGwgc3BsaXQgdGhlIGRyaXZlciBmdW5jdGlv
bmFsaXR5IGFjcm9zcyBtdWx0aXBsZSBzb3VyY2UNCj4gPiBmaWxlcyAoY29yZSwgY291bnRlciwg
cHdtKS4NCj4gDQo+IFllcy4NCg0KT2suDQoNCj4gDQo+IEJpbmRpbmdzIGRlc2lnbiBpcyBpbmRl
cGVuZGVudCBvZiBkcml2ZXIgZGVzaWduIChlLmcuIHN0aWxsIE1GRA0KPiBmcmFtZXdvcmspLg0K
DQpJIGFncmVlLCBiaW5kaW5nIGlzIGZvciBkZXNjcmliaW5nIGhhcmR3YXJlLg0KDQpDaGVlcnMs
DQpCaWp1DQo=
