Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718685E5B28
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Sep 2022 08:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiIVGPf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Sep 2022 02:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIVGPe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 22 Sep 2022 02:15:34 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2134.outbound.protection.outlook.com [40.107.113.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711778983F;
        Wed, 21 Sep 2022 23:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCI0MeQoBFhiBZcn0p/AAyMvqei5bCnH6Y1pqDz80LGhVtq0pqetthIlggRApMbBa5E1J+jP2cW1W7qNDhnpUN7C35/cAaTmWflZaxMev6WIziyFxakXJsDYHu5uUCTqI7ucMPNF6CSNevJ+mAJ7KHo9R05ZYpeLi9iwgvPySSx9yn9N7aK8u2jE176Ovt81NaSaqQC8ogeqcXvXDyrR87Qmas0kNO3iSpJzTgFYn3DXCYKYpLCBr1ZWunMs8XRJbPgDMvmXhqFWofMwI90p6C/CYMyN2TZLk56PPi+XglENMSeWLm7CfbXB5yWO0GZuAXmP4Qtz6hs+yQt/Z3/sBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYj++AUd2mgypWPHnNVm+brPkzJzINz/I/oyyliPLbk=;
 b=bFayYlKhWBpOXW5vJJvoCuhUzRaNqxUvYfZJqoSXmLDuYN0wOOaJHSSa9y5iDo/323kVTXsoR8ahnhWx+DBVd97qYLee8TtdIgYApEZDKMIwD3QgT96NxHQMZs5WRxuZ3A7hicDxz93iGl1IIU2UPi1qc4P81fjArIEuOWK99zsSlPGC7ldv51T5WRZ3sBfsYoO5FAT/jhDBSeTCnUMJA7mmAjTOL0CoGlZYlnM3sWxefl1Is9On49qqBb+FCiEhV0Mlr6ZFh5z9y7EZuMGSuSzOSYNSAUTsPo+r0RruBBBrXSnFISNjjl4W/Cx3eAIrTvEyi9rXFZPvJQisEaEfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYj++AUd2mgypWPHnNVm+brPkzJzINz/I/oyyliPLbk=;
 b=VX6i87W+nsxkegIVp1rLUL+TCB8mDXjTn8uVd1oLNCvZpUX0LJnGh1dEfTT2zMp8sSlBdQYaUdy0jVMPorJvAk50DMF8P/8uF33C8kzV3cBisO7B/fJATwShLkLjNyIacV2Y8lT2GbhwDRN8VWuzHmcgStZrClXRpG0PwVim+Oo=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10857.jpnprd01.prod.outlook.com (2603:1096:400:26f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 06:15:30 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::c502:8f9f:ec5e:8e3f%3]) with mapi id 15.20.5654.017; Thu, 22 Sep 2022
 06:15:29 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Thread-Topic: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
Thread-Index: AQHYwUrah2CK2PlWrU6yp9jjjlk8rK3meFWAgAIFOuCAABIAAIAADOWAgAEuu3CAADBRAIAAALaQgAELnoCAAAmiYA==
Date:   Thu, 22 Sep 2022 06:15:29 +0000
Message-ID: <OS0PR01MB59220ECD0B2D42DF5012B6C7864E9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220905171328.991367-1-biju.das.jz@bp.renesas.com>
 <20220905171328.991367-3-biju.das.jz@bp.renesas.com>
 <20220919075727.rmph7jmopaqvyyri@pengutronix.de>
 <OS0PR01MB5922B87D4A05973F88B427A7864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220920155306.dvcz4324zvg72udm@pengutronix.de>
 <OS0PR01MB5922A9B3314F2F2B32F6B0DE864C9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB5922289B89061F6B3DF4819F864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220921133542.3glfgeddnlhrebkz@pengutronix.de>
 <OS0PR01MB592258F2341BEDA1A5A7301C864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20220922053605.qivxzwon52orbdgz@pengutronix.de>
In-Reply-To: <20220922053605.qivxzwon52orbdgz@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10857:EE_
x-ms-office365-filtering-correlation-id: f97ca88f-eca4-4e81-5879-08da9c61d921
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uT7JtiDrKXpbeE3hB/XZtrIpCyLeSFE1TTOpZ3V7rPbsjMF8YCzlCVr8gOjMp7OF5xBpBYmkVNWDBxkYe09HpsOXvZA1DtlwKEku1xuzGUJh55ezmYIknGF5G95SmGqjOBm9bdg7d8ixBPQqBCtyPQqmeQfGiVOjs6SrV68qfkgOiC06Johmjh0NaL+xY9xiy5B+pP+PM4ZM8DO3H72ubuNRBonrz/oBQTyGy0UQxHVniy84htPOQ6D959DpaeRcf3d/PIUiHtrIcJJ/t23w59WCgWG/Aq+jLOXCnouK6D39a8ojwmKRliud8A+MrTUS2gd0ELkBmRbthznG69+DJ1is7Yfa9+6t0DzvKY0Y2fEQ2XfDpwWmw1POtddQ5HY/zy5/O3KET2IPHJoNl2RnL9s6mWO8PVEvHUmbjv/9NZ0UorBdzV+K8L6cjcQAoJTahTzbZ2ZcIgN1WUbDVscMota7N8CrywYirQ1gNg0Ibl9+voyf6GGc8yeMtLE3vn6cMKRxgUv2NJDWGCMLnjqOH6lX5D5Dcy+zSUDiMM6+0q9KwVQqC2KgF33owRVQWOK9HO6tU4/cEIebWik6y8/TTyYk/q0rp9CdY1xw4R9jVjttjZdn93Yj7Nk01yNAiAWeHtH+uQmmflHG9WMLKSq6yqaZHrV8t0bX8JQ6fVdssCRbUH6sf3Z/z2fKFnNhZuprWtKrqeNtCe7wY/5VMQTpuaFE/Y7mICZ3qU/hN1qyxfAvb8+AIiCZFl0lbeHA4NhiegkHcd9fMD9Xzdj2qnp8tMx2jlfGD4sFHh0u4A2a08A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199015)(316002)(55016003)(66446008)(478600001)(76116006)(54906003)(66556008)(4326008)(64756008)(66946007)(8676002)(122000001)(86362001)(38070700005)(38100700002)(83380400001)(66476007)(66574015)(966005)(2906002)(6916009)(5660300002)(6506007)(26005)(41300700001)(7696005)(9686003)(71200400001)(8936002)(186003)(52536014)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DZ573sV7M0wKY2F820Kqt/S+2NNi6oo6GwlBqDtMgemGpwEBwJa/xE5ncB?=
 =?iso-8859-1?Q?9z+Pu7JHPIjzXT+Y1vvwbR03w79raP63dl0VxLNP9fTfPGZT3NCgVXDIOM?=
 =?iso-8859-1?Q?3puuLYoLdoaWAeKP//kEYSPa2BvBcP1BZNhc2rYlRKF9lPySpHplsJ1zm4?=
 =?iso-8859-1?Q?QaGX+ucGOPqgSV+l0Z1AbuIDnmZohTA4J9Wma/HGDsqD1/5KeU4dEP1jt4?=
 =?iso-8859-1?Q?HuIREozJ/Q830IV3+TC+/+f96a5p6XxB8Lx1lIeZZN+iV5rQD+ZuEWUxkT?=
 =?iso-8859-1?Q?Sg6Q/R5I5/BsS/A2N4VT+f2sy5fM/0pw9UA2qoMDpuCf0D3fQGdu1F9qWd?=
 =?iso-8859-1?Q?tKDuKkE31nhVBrjxn1CJKffe2c5hZEmJOkdZJEn/8VKHgG9UtDNyloE/Id?=
 =?iso-8859-1?Q?amOez/F6uKhrPZfz6L9dtHS5In/TFxr9Le0O4+JCuTIJe6/PC5EtBHCHzW?=
 =?iso-8859-1?Q?rWCHmamkQiAMtwGV1uoJxgYxVI+EUArxzgDUrlPhAK9d5gABSgo4u8D66D?=
 =?iso-8859-1?Q?yPGRM28WMFlFeE+pt/IJ2wuPz3mkyWGs1jKFIePPAw7JIIWgmeMcXuOFxv?=
 =?iso-8859-1?Q?OKHRS7pNnGtcSXqx0vxFXCJiY1rbuQZiwzKre0Zdfuhea4Y46otmWbJwQQ?=
 =?iso-8859-1?Q?IaSVDDaTln4IdIYAB02tHCv9Bk958yxn/xiGKynLe66F/80oMHr4lrtLlf?=
 =?iso-8859-1?Q?MdRDLUWZYUckYKR38e1H1F54P3K+Cikt2YeHG/QwhIPGh82Q7KN0gYWNNb?=
 =?iso-8859-1?Q?TvEFBCxFyuI8tPJbKUIuUX9uEhiyrq4kcOlYdl0DiEz+ZDEY0ezWijXmHU?=
 =?iso-8859-1?Q?+/YKeFv4JhZGxpqtdskKb90TAlCcN0eHHQKd1Cz6beO9fjxjrWvJCcu3N+?=
 =?iso-8859-1?Q?eoxTihsYxmiiCloJdDy4qb77NCWsG+ZG2F2V0+JJRJcCuE/ebGU/4DKw5k?=
 =?iso-8859-1?Q?GF5WAeHSCUFYy/rBoG8MXtpGk7MG1WtrnjnYy6hQ32aHMoZVt44+XcbrVY?=
 =?iso-8859-1?Q?UDlGsHtop99Jz8jsd4uWCr7cYPyXfyOix1NND74/NqouQIqDs1hWn1Lg2Z?=
 =?iso-8859-1?Q?Xki1xuk7uz9JD7ftvTJaUrX31TxhwI41MlMuFJITIJKSOEUCL58Zd2qyia?=
 =?iso-8859-1?Q?+nXxpzVMEIJPHwVCuLWGQJZEjMU1PQ2jzFs1EPAkpKOzaNHN4kTyvfKOwL?=
 =?iso-8859-1?Q?Tg5kTp6R4v4idhLPjRV4zpn8nDMeBKluCadLEwiIAWJ2Ea3D/gaTbf/peb?=
 =?iso-8859-1?Q?Z9wd0AYww+LsPexG7SEARhAcIYPk2543a7my0CpMlMNXLjwOXVsyxRG5zZ?=
 =?iso-8859-1?Q?36prlRcHFQawRwj6x7iTItighbCI5vyj8TxhqDiswIsNb/Q/K87KUzlpgb?=
 =?iso-8859-1?Q?6wT8NvIfOMaclrMR4AEg4UH78NemPNef9yQwe8rPjSWTI97Xe8BZg5UEAl?=
 =?iso-8859-1?Q?4x1k1a7MPW9SfRar5JM+3cOHhba2JYcf8m10po3r25biO1+08mY/TPVxD/?=
 =?iso-8859-1?Q?UxvXT3EYlXw1RjMndhQLMG5XjgEZ0vrIVWaTAIM3SiFB4wwt8O7P+HRi5e?=
 =?iso-8859-1?Q?y1HZ7FcXAlDGFNXy/VjyZvF0Kyn6Vc17HNenM9GaU/V6wABVSHk1SkeAvY?=
 =?iso-8859-1?Q?BfPjDjgn9x8+J01K2+/R3a7i+Gm3eA86wvjDqMQdJqwSthwNrhx0yYOQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97ca88f-eca4-4e81-5879-08da9c61d921
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 06:15:29.4323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9EqHgAoHUalXboaGG/bCwge4YIbaoR5/Rz/cVkOeEQs5gND4hu5X55czds17wcBCgAQsoxyxuxAh5mA77eitV9twpKywDcRdQFY1SgGPgk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10857
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for the feedback.

> Subject: Re: [PATCH v6 2/2] pwm: Add support for RZ/G2L GPT
>=20
> Hello,
>=20
> On Wed, Sep 21, 2022 at 01:46:54PM +0000, Biju Das wrote:
> > > Actually it's worse:
> > >
> > > - When both channels are used, setting the duty-cycle on one
> aborts the
> > >   currently running period on the other and starts it anew.
> > >
> > > (Did I get this correctly?)
> >
> > I think, I have fixed that issue with the below logic Which allows
> to
> > update duty cycle on the fly.
> >
> > Now the only limitation is w.r.to disabling channels as we need to
> > disable together as stopping the counter affects both.
> >
> >       /*
> > 	 * Counter must be stopped before modifying mode, prescaler,
> timer
> > 	 * counter and buffer enable registers. These registers are
> shared
> > 	 * between both channels. So allow updating these registers only
> for the
> > 	 * first enabled channel.
> > 	 */
> > 	if (rzg2l_gpt->user_count <=3D 1)
> > 		rzg2l_gpt_disable(rzg2l_gpt);
> >
> > 	is_counter_running =3D rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) &
> RZG2L_GTCR_CST;
> > 	if (!is_counter_running)
> > 		/* GPT set operating mode (saw-wave up-counting) */
> > 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_MD,
> > 				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
>=20
> So if the PWM is already running (e.g. from the bootloader) and the
> mode is wrong, this isn't fixed? Similar problems in the if blocks
> below.

This is taken care by the above code. It stops the counter for first enable=
d channel in Linux
and then changes the mode as per Linux.

<snippet>
	if (rzg2l_gpt->user_count <=3D 1)
		rzg2l_gpt_disable(rzg2l_gpt);
</snippet>

Cheers,
Biju

>=20
> > 	/* Set count direction */
> > 	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
> >
> > 	if (!is_counter_running)
> > 		/* Select count clock */
> > 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR, RZG2L_GTCR_TPCS,
> > 				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
> >
> > 	/* Set period */
> > 	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR, pv);
> >
> > 	/* Set duty cycle */
> > 	rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(pwm->hwpwm), dc);
> >
> > 	if (!is_counter_running) {
> > 		/* Set initial value for counter */
> > 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCNT, 0);
> >
> > 		/* Set no buffer operation */
> > 		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTBER, 0);
> > 	}
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://www.pengutronix.de/ |
