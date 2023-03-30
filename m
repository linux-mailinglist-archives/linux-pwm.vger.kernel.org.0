Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85646D0272
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Mar 2023 13:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjC3LEn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Mar 2023 07:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjC3LEm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Mar 2023 07:04:42 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9471724;
        Thu, 30 Mar 2023 04:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyQ9d+SmqBZd0wPF6wzVaITpCfQKmAOFt5pvsYs92PbD5NwLC1ZVMjvAeVk44JoTjm9nb92XT4ku5zkChrmsI9fLrEVFEwZ+qeI6Gi70pM2PSBA/0tL332zCzhrugmNZ/Ixs5J5dGzt3o3kLJbvjQ2wKRIblq0XSuQY8UeXDX0sJzRmCe5yy3VeHaqMF5TcZVmb9O/ComlA//9L6YAmCLztEy13EzY4j2qO2JjhI2GZX2l/9C09FK8ZDTNfdZJSAUm6SnaoqtwnPdBWcaURqCNmsBmNpoUDFT4zU2i3Gmv49tvtCbP9OANQMIjoCKwo0IkgUwQdhoZCB5ZFn1FFCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SyrZuUCiDnt10RLaLEy0gS9KyXn9DxTble9wqgL+q4=;
 b=BAMVmeURMKeQJDRBVCWue9ceEtpqDCfT2gd2CJENLWje7BqNvbrLpoUlkrXBcsKDO8haPKn/gAwTDubKELUCv6ooAoImy+wFDwQgG0eTs7U6sKK9jh9yQH2FSI+qT5A0seDJlbcrVf9DcdFPoX0OHhNMOuvaTgoA3EvygD9ETY8ZDNUc4bcuiB4LzMoM3WN6rudaYHCmfxXi+5YDh6B82kxIiSAGvMlcM494/8ykId1HVvyxngve2nKg7q0mwO8gAL9GsJANK509vFHc7w08HD6xkWwXgeI2yLZuRof3/Ig8mADiTWqtmeb/o0m7Pk5c95D2r7evGgegdomTEVIQ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5SyrZuUCiDnt10RLaLEy0gS9KyXn9DxTble9wqgL+q4=;
 b=pznbwKDF9maT+5zWVSbyrEbpDbUAQtBFYeKvLJA9YUI0Nw/9VFjtd89yDs9IQ/xCNZ/OiKacNdKNFoACkLTuiN6fXpGCwHLpdtIuG1u1EUYL/UPG9UbfEn9RSmmaO/pmrnIF6aP5xZwCjuzOdtWiGzvjv6/RbccfAMSMiYXq63U=
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com (2603:1096:400:47::11)
 by TYCPR01MB10214.jpnprd01.prod.outlook.com (2603:1096:400:1ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 11:04:37 +0000
Received: from TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::831b:77c4:7538:9f90]) by TYCPR01MB5933.jpnprd01.prod.outlook.com
 ([fe80::831b:77c4:7538:9f90%5]) with mapi id 15.20.6254.020; Thu, 30 Mar 2023
 11:04:37 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Lee Jones <lee@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v14 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v14 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZU3LMHTd9Hvc0bUWzblzJbkvYRK8PMbMAgALss3CAADtFAIAA7gig
Date:   Thu, 30 Mar 2023 11:04:37 +0000
Message-ID: <TYCPR01MB59331C96644595A095ABAB1D868E9@TYCPR01MB5933.jpnprd01.prod.outlook.com>
References: <20230310170654.268047-1-biju.das.jz@bp.renesas.com>
 <20230310170654.268047-7-biju.das.jz@bp.renesas.com>
 <20230327204000.x67sybfbp34udwfg@pengutronix.de>
 <OS0PR01MB5922B1D75AF03CA851572AB586899@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230329205150.a4tdosjlojppigc6@pengutronix.de>
In-Reply-To: <20230329205150.a4tdosjlojppigc6@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB5933:EE_|TYCPR01MB10214:EE_
x-ms-office365-filtering-correlation-id: 49e4de37-eada-4fab-2f74-08db310e8d4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kY3SDhRuRErDotphMIO5DYrbza3R7oRYfOROiLyeS7VHQh7tymyghcOKwRMAxW3eBMqPUHCy3MQdDuQRrB8TH4Q1Lja+79PWpWqzyzYU2HKtL4fsFsGZIIAZwhB9wqGnMnHCe5NiJ++d+7YJcNHITTkZZPEJPiciP2i2wlvdjh5eVmW8vVlyZKVGrjlnTRrslAnX9ucNeYR2+MAwWbMtRXueC9VbZjb+jdECJFhWl9tAM8xGU7JxiaEgytFNUNu5WG8J6Mwm3ybMoiZgj/zgSQwaIJM5RSp3dojg2+GhdL2QupKuZ3Vv+w4Ru6/grSwnsBEZshbhU6U4lWC45SpJzBem7UmRds7GZuIzJ3z2hC/2v/Vo74P6/DTHLyvmSG6YE0udkN8Cei5OvILDcCCmW3rq27ZktQicQspTAaMXUESgIrxSXN8yFxHtdiHg6PrlnPIsJTvw9QuPtbUfRgBahCrIowRFEkfGZSUcPqcotrhqa+pukNjMIowWbQVvQ0v6yX7VQGRS/39NTeoQP+FXsHECz2VuY2w587Mh30Op41csETPLUrTdVt5k6OiZ7ht/w62WDu32OVWBMfER9nRjWa9WD7+XYzHd99ohpLRx4kiRftXQujgUpRzp74fvmcG12aA1Jr7GWH4xsOg+WjiQNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5933.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(186003)(6506007)(26005)(9686003)(478600001)(7696005)(71200400001)(4326008)(8676002)(316002)(66476007)(76116006)(64756008)(41300700001)(66556008)(66946007)(66446008)(122000001)(6916009)(2906002)(5660300002)(38100700002)(8936002)(4744005)(38070700005)(52536014)(86362001)(33656002)(55016003)(54906003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?S3Kk+ZlpUmZaX5HN5PSqy8p8st89sQRQdZ+OKMDmrVLLb/O6x6EDYztzdb?=
 =?iso-8859-1?Q?JhATg6ikznDUMi+h9BLQmt4TDYH3XVRY/VpmMlPZMTuP+ZlpqqVaHE6M0z?=
 =?iso-8859-1?Q?VtYUaza3TX2gwhcjxfbQSQ4VFVqbL5LAP/r2BSTuYxHA4NQkFDq07ShPyy?=
 =?iso-8859-1?Q?Udb+7n6+O1K3vz4gzIr49O60BXyHs8uYi4cOt4O7ONtw8DpRhIaBLFQRQH?=
 =?iso-8859-1?Q?C5fWOTCgluzGpKckNgaWZGHaXQ35VMt1TKRxc3+MPe/1r2uHkOZXOwft48?=
 =?iso-8859-1?Q?VZllZ0EpqermIH63kCVSdN+yBnwyJDGueAEbdG6dhmibD0CB5W4cQbapBW?=
 =?iso-8859-1?Q?LeNpE1rfFtAApK0bzlzTOXHA/yv75GhFgxSVT9jGIFUXRv7NrRVXz3LO73?=
 =?iso-8859-1?Q?rYRNDvcgkJer5kuT62gysXbWjnRecJkZUGDDcHc6D+bnZSo7V5OjNOrhar?=
 =?iso-8859-1?Q?6cC+YVV58dF+wZ0R1sC9LWHjEtsFnpaT8EkhSmkZ8dFESOU83zRMZRLa49?=
 =?iso-8859-1?Q?gYdPDLDQ73u09CKS8pNGLuavJ7UZK2Qa1K+qt/YO99E2PdMCKRU6MeS0IU?=
 =?iso-8859-1?Q?TaqD7Ztx6fTJASWTl9HPHPSjL7jBi0d68vWSrROx/vNhWu2cOU8Aka8tpx?=
 =?iso-8859-1?Q?zNDkjEYKamfenZEe/2d4x3gO97M0vm77dgzd9aICL3/LCIGiJuIoQHVBRu?=
 =?iso-8859-1?Q?ijLAlQY8qtwjKZBDYlhoWWEZJSAX+1LPGSFzDdkoA9rFTVxEUdkmGjbZGS?=
 =?iso-8859-1?Q?kkumc8SQgtWHnkESWJJS5E5R2QH6WDQUsCdXTbEN08N+3OiIFUAKa460+K?=
 =?iso-8859-1?Q?uuCmtiq4W1r/3EuoeqY4lmnMM96NMt2NVwZFV1cjBreETpo+wkirY0++m8?=
 =?iso-8859-1?Q?Zg5G8jXEO1ctzRVTTK9HIgr/Uep+jP9oZ2NUKNcsGGnWjTUTDMOdvHmqxc?=
 =?iso-8859-1?Q?XwnvSvK/ad3ayYdGqjHv/aErAK/atjZag+Sa64dvy2gO43HWSo7LIecuog?=
 =?iso-8859-1?Q?CR+ZdFJh6kYKwWrwMdPfrlw/7SdaWuqoGbfsYtQgdXbVbJexrd/m1VEs0g?=
 =?iso-8859-1?Q?H8ORWiq+hCYBFFtTTsRKfRUiSiDYOqsh2wBezXektR5U9WECrNbZJgae/X?=
 =?iso-8859-1?Q?z8+9Ny/EbmzKXTL79ehrUepEfB0ui18GmuqGLoGEsil6hFJi2YLMa64Gd9?=
 =?iso-8859-1?Q?gtOGhtb7mHEs8rYvm96ZTXKDHcRk3S9r9yTi5VhTz+gaSwY4E6Mk5iUBpf?=
 =?iso-8859-1?Q?xPBAxMP5ptX+UaXJrZMCXBSL4DDVBiTJmd1lFtE2aNN8lqMNj/gAT3CXRc?=
 =?iso-8859-1?Q?hKyVxH80GV+1cz/GrVj2yrU9r4kTV/qlZhM29jqGHT+xuu27H/ezkJtVtt?=
 =?iso-8859-1?Q?CX5HTG6rYcyewXBLmo+XVcwp/E0NlfHcQkiNeSi/iUdh4gQ+tAEGj25JaC?=
 =?iso-8859-1?Q?loNjiLANrurxPtWqyQYGyYJsLB6ftSUiZzAFIq44OV6NEDkhr0mL7w00RV?=
 =?iso-8859-1?Q?AVs7zY4+x2j/33Kwa6dAcbEOd3qsW3egTxVIFs1f2zPBZvcgRSZnOR4suc?=
 =?iso-8859-1?Q?osA3Rsg7NM4GdhqvVrSOAq7WfSq9uhiwGpAcwFxhJeenamDEli9WQJQgMd?=
 =?iso-8859-1?Q?zFSiiJPOQW2CE7HYYc4zXEoZM1o+UHL00DJOT9qxD08pJI65kaw9xNWA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5933.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e4de37-eada-4fab-2f74-08db310e8d4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 11:04:37.2866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V+6anLWQMdGw3Un87hLT5uo8v7aYCaXiEwPiscT7Gof43FZN6NNms8tAxqhQ6RuFShM5m+6USrbmSsfXbnzLGxPBGtUrAIm6DqJZ2GOeMI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10214
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH v14 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> Hello Biju,
>=20
> On Wed, Mar 29, 2023 at 05:40:17PM +0000, Biju Das wrote:
> > [...]
>=20
> IMHO it's easier to send a v15 instead of discussing what you made of my
> suggestions in prosa.

Ok, will send v15.

>=20
> > > .probe() enables rz_mtu3_pwm->clk, but there is no .remove() that
> > > cares about disabling it again.
> >
> > I believe it is ok. I have added WARN_ON for double checking.
> > Please correct me, if it is wrong.
>=20
> I might have missed some details in the runtime pm stuff. I'll happily
> recheck if you resend with the other things we agreed on fixed.

Thanks,
Biju
