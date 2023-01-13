Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE83669654
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jan 2023 13:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjAMMDo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Jan 2023 07:03:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjAMMCi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Jan 2023 07:02:38 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2094.outbound.protection.outlook.com [40.107.114.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8896831B3;
        Fri, 13 Jan 2023 03:54:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBzm/VwdOOfDAhTOyvQgWfTlPITtSwBkr6K2gyAUt/aOFjdNsA8ug3R5J9M7pR19GpiDUZgVPX1S9AsPViq5W0mM8VeMKkbi527Oy01PEaNxn91Qk2B1AsyvAQ0hepbJgJUSInnMO5O4kn7NIV1DSauGAzvNfl86KjTU5htSLHtHhL8HwWugVW+ZF/qxtEdtswdL81bZ2BwKuCyDBISq+Cd42YVsw2X0fDXvcwH4yyHHqGE1SgFG6Z+fBi5170uARg3MbV4+FAF+RApVx0X8IhqISTnJQGsBTq19MjAcbcLppUUu5ewXcIYlKzGGFqxZxIFYtmA+bYtLdwvpzTpcWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvM8sCtrUZeMnjnNPo57yw+QPLRfUNeURv1zhFF63to=;
 b=nWsqare5+kORtDBlB6LYvuqGZsYU8w8bih/s6lfMkUF4EjIZYuQuI/TBFt/sAV4FaE3zYwM0h2bd9SurxyWVWSdc62eJhssYwvH8Xx68bnEYA8LQn3WjhZMlqh9SX7ZRqZ6wZFFB0yd5wpC7AfCtU7XwrM/6HBlaVNz+lEGECKCQtNkmH003Rds5mbL6/hELPCHnSJoFdvzgx/3B/9jBVa49AB0uFnoNWoAue2Ad4lGxuHPgxkJlxz0CFeqCfC5vvPR/6bjv6aV9MknyVtIK41GlSV7AfiIumr1nIWZpBYHSmDUQ9qKVPuWsGWPm9xu8QaTXQ8yPDMXzwnpF59S/aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvM8sCtrUZeMnjnNPo57yw+QPLRfUNeURv1zhFF63to=;
 b=C7oojJpbtyYe2fIpsi7JUlgRL8X20/+ZbXl7CfonGuyxJDPSD4tTP/7TMJlSE7sD8Krbv2d5o3D4FqA1VjM2D3jOnSZHoj5fznSlWHHMiiAQ2fEsp3OixduMeRqgkMV1YcnEKGOOGgaYZXd8pQvcJURbIeRWO98r0dotWf87c2g=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYCPR01MB9974.jpnprd01.prod.outlook.com (2603:1096:400:1ea::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 11:54:09 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ac31:35cd:10d6:4ad2]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::ac31:35cd:10d6:4ad2%8]) with mapi id 15.20.6002.012; Fri, 13 Jan 2023
 11:54:09 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v12 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v12 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHZD78pyg0xDVzFk0Otldnshq8z266ZXBOAgAMKxwA=
Date:   Fri, 13 Jan 2023 11:54:09 +0000
Message-ID: <TYCPR01MB593359F22A9A9229994973D086C29@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20221214132232.2835828-1-biju.das.jz@bp.renesas.com>
 <20221214132232.2835828-3-biju.das.jz@bp.renesas.com>
 <CAMuHMdVL0U85fUXRdMV8TT1QwkzAfo_6baNa7wR6_bL6wS-BfQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVL0U85fUXRdMV8TT1QwkzAfo_6baNa7wR6_bL6wS-BfQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|TYCPR01MB9974:EE_
x-ms-office365-filtering-correlation-id: e3f2d8ee-11cd-4765-5b65-08daf55ce177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zCJgEQ9v4Tgjsklh5Cmiuv9GQsk7u4jNV0oMbZHmJG9Em8ZRS/AsyiMtPqzj+nPc+kiBYwqMSpH8B4yfNKBZxe/ZmXx1rvYxnQRBsil+bTUqG8EhdYnw+YJ9cC2jHIvylciAxJ+ot5UKX33c75EXtIRnFK7xybEzAi8Wx/0dsQ1t2nTSa1wU7hWGok4xC/yMGKaruAH3dM+L4BXT2jepAA9NZktlSKuoMAZT1MMOe2/KBmx98O+dgwhEaNtzDHSY4aHvJwNsVAYA+eiSpO9ykZ30H3AInaw3Eoh68tUnRPl8OSLHodd6R85Sn2sW0LjjundCfTeQCzjwwi8zZvQ7AyRimJ6EtDMKztT1I/44VbP6pda9ETumocPY6upnB4U+btIjJm2Zvxe2VTz5BIVDh04j2eTHHqJ2/OvxKy2+Sv/6bbyH2QmBpHGVvDI9t3dd0KUgO9j3IB+sbqEosRsLJ3pFdT412MyI85+8IC9tlmmmLv+HOGVCw9P+n2tBlTi7HDPmL0iyB7jUfA3natjlOldMjp1bJ06EOFoqxvvBP4WZ7OPVChcQ71IvUmV1awNQv0qUHwTXtZQhqN73QrIGhFyMj+/ZDsoQ7iFBtAhzg8iRyShkuGkC2kj8zAr8LDs6u8Zg6u+op6H03l/hCowOQd1at8ObRfj4a9KFac5dmk59TYFqsiXECBX/nRPrcHVsEw8zkZF9NP2G5TfobBHpUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199015)(66556008)(41300700001)(52536014)(8676002)(122000001)(6916009)(66476007)(66946007)(64756008)(4326008)(76116006)(66446008)(5660300002)(54906003)(38070700005)(8936002)(316002)(2906002)(86362001)(38100700002)(71200400001)(7696005)(478600001)(9686003)(186003)(26005)(55016003)(6506007)(53546011)(33656002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1lsY2gzVElzaUpBTFJtZlpSa1dMcEtDSWs1cDRVVzk0eGpRdUdOaUVFaU11?=
 =?utf-8?B?Y01FVEVwMjRVRS9UOWdwMy83azNpSjM0WkZFYnRvT3FJeG1hMFZic0hmZ3JJ?=
 =?utf-8?B?QlZGb3NzaDVzRzRzcVNmNHo5cnZDSHh3TncrZFp4dXBrOUxtNmVVU1RsVzRK?=
 =?utf-8?B?YTQwM0JrZTR4U1ljLzlHYnQ2RXFodmMvWnlPMThod1NGcnNSbzdJYTZPNnRN?=
 =?utf-8?B?cXVYeUJXSkJ5WVZYSDNRUUZtOWhSSGpZOExOVncxSDlHQ3NzUC8xYzVmNWdq?=
 =?utf-8?B?VjdLbzBXTHp3NXU3SEhPTGFXK1R1SVpONFBvL0k2cEowMFEzTmp2dUdVb0FH?=
 =?utf-8?B?NFZyRVhzL0xRU05zWVlMRVlNS3JwM3NXaXptMXgwbkRoWW5iUFdpY1dsYWRG?=
 =?utf-8?B?elRSZnVKYkJTM1BiUEpuSlYzbWxNN2s3bm94VDYrM3ZaNUtZdERTWWFkOHhS?=
 =?utf-8?B?RmdvNHZnTlVQTkl5V1ZUZ3ZZMWtPazk4WHNFaUVGUGUzMUJXRmtodnRvWFBx?=
 =?utf-8?B?QjF2bDM1ZWVsSGhidHlLZzJFTWRROVltT3Erek91YlBzSHM1QVVsMmdVREFp?=
 =?utf-8?B?dmt4UHhLM0w2ZHhBenF6SmVSc2VZa2w5VnZ3ZURmUENNTlhMKzVwdG9oeS8r?=
 =?utf-8?B?WVpvR3hhbExCUlNoQ3lFVVU0MWk3dE52V1djMjB1ZnNQdXl4aVF5dDJTd1VI?=
 =?utf-8?B?azlmRjRyeSsrMXdacVVLMkY4am55M3ZoVEpSWS81Wjc3SEtRMWw4UjZXUDBX?=
 =?utf-8?B?dmdSU0ZpZ1dGU1ZhMWUwV1I2RWcwTDRqb1MvaFFXYS83dWpGQ2tXUVVCYjg4?=
 =?utf-8?B?VVBxdVVVK2lFVDFQbWRxeEY2VnBhVHVXbTRxNUtIOGRtMWpCUVVjU1pxZHcz?=
 =?utf-8?B?ZUhCbmJJL1c2dHc3aVdUWWdPbTZCcTdzNEhjR0xTQjhTMlcwYnlGSUk4dmQx?=
 =?utf-8?B?K016cUNMVElhREdTUTg1R1dqUW1ETjM3RW1yT01WZ2hGK2RHQ0dqUk15SnlW?=
 =?utf-8?B?Yk9zYk01Qjh0S2lXM2gzcjJhTUg3WWl6bVVpaTEzZXlqa2VUZElTakJLTm81?=
 =?utf-8?B?YWdKdnZyL0YrZ25QSG5DVWpxTTdleUlEb3RTM2hkUXdTbDBock9aVXNQMmJD?=
 =?utf-8?B?cExZUmwrOFRpajNSVmFtazJOTDJDV3pNYzBhTGZEd2NaMFpKbFFkQWNkN3Qz?=
 =?utf-8?B?TFdoVnVySG9UR1pjaVB3RWU1WHRZVSttcUlYNzYvdWFUcVR1SG9pVVlWQ3Bi?=
 =?utf-8?B?Y09MWmFENHgwVEczY3NEWXVkUFVFbXUxdmRQTDVrVFB1M2xJQjA2Ny8zSkdz?=
 =?utf-8?B?WG1oQTQ5TkdqaFpEMkJOL0FPMlpKNmJpOUxFRmNMQjlGcXFpODVUTi9ETTFl?=
 =?utf-8?B?R0VkTFVGYjdPZGh4KzQ0bXlwZ1pBaGk5THBRR0xMN29KMC9YREdLL0M2RjZ3?=
 =?utf-8?B?NzdVU0c4MEUzSGxYbW1GdkVjTVl2WFlsN0pLRFBHaDVWYWNnbU9qQnU1aVd4?=
 =?utf-8?B?SzVJVVQvYmREcUlweklwZjNoMzIxcG05MHJTVm1lL2tlWkR6bVE1b0RyZUNL?=
 =?utf-8?B?ZXBHU1JTWDVpQzdWaVc4RHZuZEtoR1gwVFcrT2FQejJNNkV6OFNsQVZac2ww?=
 =?utf-8?B?cElPNDhhSkZadHVSamg5TGUwNVBXdmM5VkZzSWgrS3ZRbmwrWWRER0xZQ21y?=
 =?utf-8?B?KzUybDBCSXBBVUZDdHV3czBoRE1KNnV2b3dLU0tycURRbWYxR0FNNHVQYkVR?=
 =?utf-8?B?OWJMc00rLzhEdmsyZXRkWkdXcXVjSTNQcTRYWXBiL2NMTzRpbFJFY3dmQUw2?=
 =?utf-8?B?R1hMemdLNU5XR05hWUQ5ekEzUytEdkVpZXFZL0hVWG1laTZuT3dFakNYUFhM?=
 =?utf-8?B?SEY5S05jQ01XV1lnMld2MUY3THVmWDJuRVpiY2dDRzJvT1J0NVpBMm5rNDlj?=
 =?utf-8?B?MERWbjJmYnZ4M0NkYysrYUVsUHdkRVlkSTIzd08xMXlmTFhpTVA3RDlXYmVD?=
 =?utf-8?B?U3RTeVdZVzNib2FSREUxVitRNDJzdHRzUzRQdkxXaHgwei9JZHEzS3RUNXNv?=
 =?utf-8?B?UVBxR0NJYzJCNjY3NGZWdVBhVXY5MmV5anNtYzBnSFE0U25pSmxscDVmY2No?=
 =?utf-8?B?QkpncHEycnpibWNBclV2NVNsdXVqZElNUnE4SDAzSEZiNzlMK2xOM2FDSDJi?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f2d8ee-11cd-4765-5b65-08daf55ce177
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 11:54:09.4213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1ocrgy9RSa+moNXuXZgOVYZCMfR7628s8YqjXavintkCg9fV3E3pylVBnPcAA0BXJQsNLevgU1rqEQBDLV4EyAQXNT8bjhiBHLGaCdKaK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9974
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjEyIDIvMl0gcHdtOiBBZGQgc3VwcG9ydCBmb3IgUlovRzJMIEdQVA0KPiANCj4gSGkg
QmlqdSwNCj4gDQo+IE9uIFdlZCwgRGVjIDE0LCAyMDIyIGF0IDI6MjIgUE0gQmlqdSBEYXMgPGJp
anUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPiB3cm90ZToNCj4gPiBSWi9HMkwgR2VuZXJhbCBQV00g
VGltZXIgKEdQVCkgY29tcG9zZWQgb2YgOCBjaGFubmVscyB3aXRoIDMyLWJpdA0KPiA+IHRpbWVy
IChHUFQzMkUpLiBJdCBzdXBwb3J0cyB0aGUgZm9sbG93aW5nIGZ1bmN0aW9ucw0KPiA+ICAqIDMy
IGJpdHMgw5cgOCBjaGFubmVscw0KPiA+ICAqIFVwLWNvdW50aW5nIG9yIGRvd24tY291bnRpbmcg
KHNhdyB3YXZlcykgb3IgdXAvZG93bi1jb3VudGluZw0KPiA+ICAgICh0cmlhbmdsZSB3YXZlcykg
Zm9yIGVhY2ggY291bnRlci4NCj4gPiAgKiBDbG9jayBzb3VyY2VzIGluZGVwZW5kZW50bHkgc2Vs
ZWN0YWJsZSBmb3IgZWFjaCBjaGFubmVsDQo+ID4gICogVHdvIEkvTyBwaW5zIHBlciBjaGFubmVs
DQo+ID4gICogVHdvIG91dHB1dCBjb21wYXJlL2lucHV0IGNhcHR1cmUgcmVnaXN0ZXJzIHBlciBj
aGFubmVsDQo+ID4gICogRm9yIHRoZSB0d28gb3V0cHV0IGNvbXBhcmUvaW5wdXQgY2FwdHVyZSBy
ZWdpc3RlcnMgb2YgZWFjaCBjaGFubmVsLA0KPiA+ICAgIGZvdXIgcmVnaXN0ZXJzIGFyZSBwcm92
aWRlZCBhcyBidWZmZXIgcmVnaXN0ZXJzIGFuZCBhcmUgY2FwYWJsZSBvZg0KPiA+ICAgIG9wZXJh
dGluZyBhcyBjb21wYXJpc29uIHJlZ2lzdGVycyB3aGVuIGJ1ZmZlcmluZyBpcyBub3QgaW4gdXNl
Lg0KPiA+ICAqIEluIG91dHB1dCBjb21wYXJlIG9wZXJhdGlvbiwgYnVmZmVyIHN3aXRjaGluZyBj
YW4gYmUgYXQgY3Jlc3RzIG9yDQo+ID4gICAgdHJvdWdocywgZW5hYmxpbmcgdGhlIGdlbmVyYXRp
b24gb2YgbGF0ZXJhbGx5IGFzeW1tZXRyaWMgUFdNIHdhdmVmb3Jtcy4NCj4gPiAgKiBSZWdpc3Rl
cnMgZm9yIHNldHRpbmcgdXAgZnJhbWUgY3ljbGVzIGluIGVhY2ggY2hhbm5lbCAod2l0aCBjYXBh
YmlsaXR5DQo+ID4gICAgZm9yIGdlbmVyYXRpbmcgaW50ZXJydXB0cyBhdCBvdmVyZmxvdyBvciB1
bmRlcmZsb3cpDQo+ID4gICogR2VuZXJhdGlvbiBvZiBkZWFkIHRpbWVzIGluIFBXTSBvcGVyYXRp
b24NCj4gPiAgKiBTeW5jaHJvbm91cyBzdGFydGluZywgc3RvcHBpbmcgYW5kIGNsZWFyaW5nIGNv
dW50ZXJzIGZvciBhcmJpdHJhcnkNCj4gPiAgICBjaGFubmVscw0KPiA+ICAqIFN0YXJ0aW5nLCBz
dG9wcGluZywgY2xlYXJpbmcgYW5kIHVwL2Rvd24gY291bnRlcnMgaW4gcmVzcG9uc2UgdG8gaW5w
dXQNCj4gPiAgICBsZXZlbCBjb21wYXJpc29uDQo+ID4gICogU3RhcnRpbmcsIGNsZWFyaW5nLCBz
dG9wcGluZyBhbmQgdXAvZG93biBjb3VudGVycyBpbiByZXNwb25zZSB0byBhDQo+ID4gICAgbWF4
aW11bSBvZiBmb3VyIGV4dGVybmFsIHRyaWdnZXJzDQo+ID4gICogT3V0cHV0IHBpbiBkaXNhYmxl
IGZ1bmN0aW9uIGJ5IGRlYWQgdGltZSBlcnJvciBhbmQgZGV0ZWN0ZWQNCj4gPiAgICBzaG9ydC1j
aXJjdWl0cyBiZXR3ZWVuIG91dHB1dCBwaW5zDQo+ID4gICogQS9EIGNvbnZlcnRlciBzdGFydCB0
cmlnZ2VycyBjYW4gYmUgZ2VuZXJhdGVkIChHUFQzMkUwIHRvIEdQVDMyRTMpDQo+ID4gICogRW5h
YmxlcyB0aGUgbm9pc2UgZmlsdGVyIGZvciBpbnB1dCBjYXB0dXJlIGFuZCBleHRlcm5hbCB0cmln
Z2VyDQo+ID4gICAgb3BlcmF0aW9uDQo+ID4NCj4gPiBUaGlzIHBhdGNoIGFkZHMgYmFzaWMgcHdt
IHN1cHBvcnQgZm9yIFJaL0cyTCBHUFQgZHJpdmVyIGJ5IGNyZWF0aW5nDQo+ID4gc2VwYXJhdGUg
bG9naWNhbCBjaGFubmVscyBmb3IgZWFjaCBJT3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBC
aWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gdjExLT52
MTI6DQo+ID4gICogQWRkZWQgcmV0dXJuIGNvZGUgZm9yIGdldF9zdGF0ZSgpDQo+ID4gICogQ2Fj
aGUgZHV0eSBjeWNsZS9wcmVzY2FsZSBhcyB0aGUgZHJpdmVyIGNhbm5vdCByZWFkIHRoZSBjdXJy
ZW50IGR1dHkNCj4gPiAgICBjeWNsZS9wcmVzY2FsZSBmcm9tIHRoZSBoYXJkd2FyZSBpZiB0aGUg
aGFyZHdhcmUgaXMgZGlzYWJsZWQuIENhY2hlIHRoZQ0KPiA+ICAgIGxhc3QgcHJvZ3JhbW1lZCBk
dXR5IGN5Y2xlL3ByZXNjYWxlIHZhbHVlIHRvIHJldHVybiBpbiB0aGF0IGNhc2UuDQo+ID4gICog
VXBkYXRlZCByemcybF9ncHRfZW5hYmxlIHRvIGVuYWJsZSB0aGUgY2xvY2tzLg0KPiA+ICAqIFVw
ZGF0ZWQgcnpnMmxfZ3B0X2Rpc2FibGUgdG8gZGlzYWJsZSB0aGUgY2xvY2tzLg0KPiA+ICAqIFVw
ZGF0ZWQgcnpnMmxfZ3B0X2NvbmZpZygpIHRvIGNhY2hlIGR1dHkgY3VjbGUvcHJlc2NhbGUgdmFs
dWUNCj4gPiAgKiBVcGRhdGVkIHJ6ZzJsX2dwdF9nZXRfc3RhdGUgdG8gdXNlIGNhY2hlZCB2YWx1
ZSBvZiBkdXR5DQo+IGN5Y2xlL3ByZXNjYWxlLElmIHRoZSBQV00NCj4gPiAgICBpcyBkaXNhYmxl
ZC4NCj4gPiAgKiBTaW1wbGlmaWVkIHJ6ZzJsX2dwdF9hcHBseSgpDQo+ID4gICogQWRkZWQgY29t
bWVudHMgaW4gcnpnMmxfZ3B0X3Jlc2V0X2Fzc2VydF9wbV9kaXNhYmxlKCkNCj4gDQo+IFRoYW5r
cyBmb3IgdGhlIHVwZGF0ZSENCj4gDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZl
cnMvcHdtL3B3bS1yemcybC1ncHQuYw0KPiANCj4gPiArc3RydWN0IHJ6ZzJsX2dwdF9jaGlwIHsN
Cj4gPiArICAgICAgIHN0cnVjdCBwd21fY2hpcCBjaGlwOw0KPiA+ICsgICAgICAgdm9pZCBfX2lv
bWVtICptbWlvOw0KPiA+ICsgICAgICAgc3RydWN0IHJlc2V0X2NvbnRyb2wgKnJzdGM7DQo+ID4g
KyAgICAgICBzdHJ1Y3QgY2xrICpjbGs7DQo+ID4gKyAgICAgICBzdHJ1Y3QgbXV0ZXggbG9jazsN
Cj4gPiArICAgICAgIHVuc2lnbmVkIGxvbmcgcmF0ZTsNCj4gPiArICAgICAgIHUzMiBzdGF0ZV9w
ZXJpb2RbUlpHMkxfTUFYX0hXX0NIQU5ORUxTXTsNCj4gPiArICAgICAgIHUzMiB1c2VyX2NvdW50
W1JaRzJMX01BWF9IV19DSEFOTkVMU107DQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAgICog
VGhlIGRyaXZlciBjYW5ub3QgcmVhZCB0aGUgY3VycmVudCBkdXR5IGN5Y2xlL3ByZXNjYWxlIGZy
b20gdGhlDQo+ID4gKyAgICAgICAgKiBoYXJkd2FyZSBpZiB0aGUgaGFyZHdhcmUgaXMgZGlzYWJs
ZWQuIENhY2hlIHRoZSBsYXN0IHByb2dyYW1tZWQNCj4gPiArICAgICAgICAqIGR1dHkgY3ljbGUv
cHJlc2NhbGUgdmFsdWUgdG8gcmV0dXJuIGluIHRoYXQgY2FzZS4NCj4gPiArICAgICAgICAqLw0K
PiA+ICsgICAgICAgdTggcHJlc2NhbGVbUlpHMkxfTUFYX0hXX0NIQU5ORUxTXTsNCj4gPiArICAg
ICAgIHVuc2lnbmVkIGludCBkdXR5X2N5Y2xlW1JaRzJMX01BWF9QV01fQ0hBTk5FTFNdOw0KPiAN
Cj4gdTMyPyBUaGUgbWF4aW11bSB2YWx1ZSBzdG9yZWQgaXMgVTMyX01BWC4NCg0KQWdyZWVkLg0K
DQo+IA0KPiA+ICt9Ow0KPiANCj4gPiArc3RhdGljIGludCByemcybF9ncHRfZ2V0X3N0YXRlKHN0
cnVjdCBwd21fY2hpcCAqY2hpcCwgc3RydWN0IHB3bV9kZXZpY2UNCj4gKnB3bSwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHB3bV9zdGF0ZSAqc3RhdGUpIHsNCj4g
PiArICAgICAgIHN0cnVjdCByemcybF9ncHRfY2hpcCAqcnpnMmxfZ3B0ID0gdG9fcnpnMmxfZ3B0
X2NoaXAoY2hpcCk7DQo+ID4gKyAgICAgICB1MzIgY2hfaW5kZXggPSBSWkcyTF9HRVRfQ0hfSU5E
RVgocHdtLT5od3B3bSk7DQo+ID4gKyAgICAgICB1MzIgb2ZmcyA9IFJaRzJMX0dFVF9DSF9PRkZT
KGNoX2luZGV4KTsNCj4gPiArICAgICAgIHU4IHByZXNjYWxlOw0KPiA+ICsgICAgICAgdTY0IHRt
cDsNCj4gPiArICAgICAgIHUzMiB2YWw7DQo+ID4gKw0KPiA+ICsgICAgICAgcG1fcnVudGltZV9n
ZXRfc3luYyhjaGlwLT5kZXYpOw0KPiA+ICsgICAgICAgdmFsID0gcnpnMmxfZ3B0X3JlYWQocnpn
MmxfZ3B0LCBvZmZzICsgUlpHMkxfR1RDUik7DQo+ID4gKyAgICAgICBzdGF0ZS0+ZW5hYmxlZCA9
IHJ6ZzJsX2dwdF9pc19jaF9lbmFibGVkKHJ6ZzJsX2dwdCwgcHdtLT5od3B3bSk7DQo+ID4gKyAg
ICAgICBpZiAoc3RhdGUtPmVuYWJsZWQpIHsNCj4gPiArICAgICAgICAgICAgICAgcHJlc2NhbGUg
PSBGSUVMRF9HRVQoUlpHMkxfR1RDUl9UUENTLCB2YWwpOw0KPiA+ICsNCj4gPiArICAgICAgICAg
ICAgICAgdmFsID0gcnpnMmxfZ3B0X3JlYWQocnpnMmxfZ3B0LCBvZmZzICsgUlpHMkxfR1RQUik7
DQo+ID4gKyAgICAgICAgICAgICAgIHRtcCA9IE5TRUNfUEVSX1NFQyAqICh1NjQpdmFsOw0KPiA+
ICsgICAgICAgICAgICAgICBzdGF0ZS0+cGVyaW9kID0gRElWX1JPVU5EX1VQX1VMTCh0bXAsIHJ6
ZzJsX2dwdC0+cmF0ZSkNCj4gPiArIDw8ICgyICogcHJlc2NhbGUpOw0KPiA+ICsNCj4gPiArICAg
ICAgICAgICAgICAgdmFsID0gcnpnMmxfZ3B0X3JlYWQocnpnMmxfZ3B0LA0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvZmZzICsgUlpHMkxfR1RDQ1IoUlpHMkxfSVNf
SU9CKHB3bS0NCj4gPmh3cHdtKSkpOw0KPiA+ICsgICAgICAgICAgICAgICB0bXAgPSBOU0VDX1BF
Ul9TRUMgKiAodTY0KXZhbDsNCj4gPiArICAgICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAg
ICAgIC8qIElmIHRoZSBQV00gaXMgZGlzYWJsZWQsIHVzZSB0aGUgY2FjaGVkIHZhbHVlLiAqLw0K
PiA+ICsgICAgICAgICAgICAgICBwcmVzY2FsZSA9IHJ6ZzJsX2dwdC0+cHJlc2NhbGVbY2hfaW5k
ZXhdOw0KPiA+ICsgICAgICAgICAgICAgICB0bXAgPSBOU0VDX1BFUl9TRUMgKg0KPiA+ICsgKHU2
NClyemcybF9ncHQtPmR1dHlfY3ljbGVbcHdtLT5od3B3bV07DQo+IA0KPiBOaXQ6IEp1c3Qgc2V0
ICJ2YWwgPSByemcybF9ncHQtPmR1dHlfY3ljbGVbcHdtLT5od3B3bV07IiwgYW5kIGZhY3RvciAi
dG1wID0NCj4gTlNFQ19QRVJfU0VDICogKHU2NCl2YWw7IiBvdXQgb2YgdGhlIGlmLXN0YXRlbWVu
dC4NCg0KT0suDQoNCj4gDQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgc3RhdGUt
PmR1dHlfY3ljbGUgPSBESVZfUk9VTkRfVVBfVUxMKHRtcCwgcnpnMmxfZ3B0LT5yYXRlKSA8PCAo
MiAqDQo+IHByZXNjYWxlKTsNCj4gPiArICAgICAgIHN0YXRlLT5wb2xhcml0eSA9IFBXTV9QT0xB
UklUWV9OT1JNQUw7DQo+ID4gKyAgICAgICBwbV9ydW50aW1lX3B1dChjaGlwLT5kZXYpOw0KPiA+
ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+IA0KPiA+ICtzdGF0aWMgaW50IF9f
bWF5YmVfdW51c2VkIHJ6ZzJsX2dwdF9wbV9ydW50aW1lX3N1c3BlbmQoc3RydWN0IGRldmljZQ0K
PiA+ICsqZGV2KSB7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcnpnMmxfZ3B0X2NoaXAgKnJ6ZzJsX2dw
dCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsNCj4gPiArICAgICAgIGNsa19kaXNhYmxl
X3VucHJlcGFyZShyemcybF9ncHQtPmNsayk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIDA7
DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgcnpnMmxfZ3B0
X3BtX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UNCj4gPiArKmRldikgew0KPiA+ICsgICAg
ICAgc3RydWN0IHJ6ZzJsX2dwdF9jaGlwICpyemcybF9ncHQgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsNCj4gPiArDQo+ID4gKyAgICAgICBjbGtfcHJlcGFyZV9lbmFibGUocnpnMmxfZ3B0LT5jbGsp
Ow0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IGRldl9wbV9vcHMgcnpnMmxfZ3B0X3BtX29wcyA9IHsNCj4gPiArICAg
ICAgIFNFVF9SVU5USU1FX1BNX09QUyhyemcybF9ncHRfcG1fcnVudGltZV9zdXNwZW5kLA0KPiA+
ICtyemcybF9ncHRfcG1fcnVudGltZV9yZXN1bWUsIE5VTEwpIH07DQo+IA0KPiBERUZJTkVfUlVO
VElNRV9ERVZfUE1fT1BTKCksIHNvIHlvdSBjYW4gZHJvcCB0aGUgX19tYXliZV91bnVzZWQgZnJv
bSB0aGUNCj4gY2FsbGJhY2tzLg0KDQpBZ3JlZWQuDQoNCj4gDQo+ID4gK3N0YXRpYyBzdHJ1Y3Qg
cGxhdGZvcm1fZHJpdmVyIHJ6ZzJsX2dwdF9kcml2ZXIgPSB7DQo+ID4gKyAgICAgICAuZHJpdmVy
ID0gew0KPiA+ICsgICAgICAgICAgICAgICAubmFtZSA9ICJwd20tcnpnMmwtZ3B0IiwNCj4gPiAr
ICAgICAgICAgICAgICAgLnBtID0gJnJ6ZzJsX2dwdF9wbV9vcHMsDQo+IA0KPiBwbV9wdHIoJnJ6
ZzJsX2dwdF9wbV9vcHMpPw0KDQpPSy4NCg0KPiANCj4gPiArICAgICAgICAgICAgICAgLm9mX21h
dGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKHJ6ZzJsX2dwdF9vZl90YWJsZSksDQo+ID4gKyAgICAg
ICB9LA0KPiA+ICsgICAgICAgLnByb2JlID0gcnpnMmxfZ3B0X3Byb2JlLA0KPiA+ICt9Ow0KPiA+
ICttb2R1bGVfcGxhdGZvcm1fZHJpdmVyKHJ6ZzJsX2dwdF9kcml2ZXIpOw0KDQpXaWxsIHNlbmQg
VjEzIHdpdGggYmVsb3cgY2hhbmdlcyBhcyB3ZWxsLg0KDQoxKSBSZXBsYWNlZCB0aGUgZGVwZW5k
ZW5jeSBmcm9tIEFSQ0hfUkVORVNBUy0+QVJDSF9SWkcyTCBpbiBLY29uZmlnDQoyKSBTb3J0ZWQg
dGhlIGhlYWRlciAjaW5jbHVkZSA8bGludXgvbGltaXRzLmg+IGFscGhhYmV0aWNhbGx5DQozKSBB
ZGRlZCBhIGNvbW1lbnQgaW4gbXV0ZXhfbG9jayB0byBmaXggY2hlY2sgcGF0Y2ggd2FybmluZw0K
NCkgUmVtb3ZlZCB0aGUgdW53YW50ZWQgY29kZSBmcm9tIHJ6ZzJsX2dwdF9jb25maWcuDQotICAg
ICAgIGR1dHlfY3ljbGVzID0gc3RhdGUtPmR1dHlfY3ljbGU7DQotICAgICAgIGlmICghc3RhdGUt
PmVuYWJsZWQpDQotICAgICAgICAgICAgICAgZHV0eV9jeWNsZXMgPSAwOw0KLQ0KDQpDaGVlcnMs
DQpCaWp1DQo=
