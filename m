Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC66070B74B
	for <lists+linux-pwm@lfdr.de>; Mon, 22 May 2023 10:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjEVIGo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 May 2023 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjEVIGn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 May 2023 04:06:43 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2129.outbound.protection.outlook.com [40.107.113.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4916BAA;
        Mon, 22 May 2023 01:06:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idyLMLtjJL4XOuk7G2SaW3mGdo37AIM5r+M3dDMtJl8azPngpMWh2KHlj080dkElNMwFskqfvzuYRilpLVPw2O+T9FBHux0JVGIFCsbrfzidpeVr+R93cAOwgqP3fgWCBtm5tJwd4Tyd+Up4xHorWIl877D4ftxeOi/GfzullJ6An9bPJWTYmXfC19GxZPNYH2UdDSsflSVuzIiU3r19AcyCjJfRT/XCY4chBBmTf2/Eioh464Y0K2fgCcO9trFYzYm9nismA2cgXMgzaOJI6fUhldRGSOFwFPzeWuBqsWP9sU2Fd/dnGIcHNq9exoQVgAm41c2vDDJ5gfWuBgKRtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38CoKWxE8LxWE1CSbdViAuEcN9IDgiL4A/VF/JkU7wo=;
 b=DxN0ZwJc0O+zhhDqP3tnhc272CqSzYEFWy5ckk56BdJtr/XN+qIGH4BLJ+frhivdE2oHyoFyYiHGe50QpuK0j318sdvxIE+zKri8a04mlpEs+9PuxGOrYYH+1BqzMWOzmm5dgO0FsEcpe+u8YY77NJE+R8soJ+rWHwnFSk0lg2sqF+bZPHc16ypc9xBLefWfpLeZTCK170pfs2fNbx6NKniIqPQQ7VHD7fbOx6GzQNcdluYHJjGg747N/zWXMIHS6e3JihnrceKvj2N6Cku8NpymuqwRdslL+sOmB4g6jANWuB+ODZxcVy7CV/MGTSb0b1ljXjKIQDbGYRPXw0M1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38CoKWxE8LxWE1CSbdViAuEcN9IDgiL4A/VF/JkU7wo=;
 b=fZe5MTIeZoMebBwKiUmGhVM1e4TnvnXfgnM0WPg5Nv0tTm+m098a7PQNmXHMy5Raetr6ZNwC/WQRvwjCVFThaHs1eHPVFpLER7nbiwaG+4MQYyTX0Wnd5CCNLvxMIXhTYGqSS5fppeJeS2URYTiRXLRT/J6rgO86u+n+aR0QOgQ=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10915.jpnprd01.prod.outlook.com (2603:1096:400:3a9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 08:06:38 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 08:06:38 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZcd9vSL7mgT59Q0WiNyhNNIZK3a9cn5UAgAAE9HCACXHVMIAACXwAgAAD6CA=
Date:   Mon, 22 May 2023 08:06:38 +0000
Message-ID: <OS0PR01MB59221AED9A2CF1E351BA923086439@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230418102037.346405-1-biju.das.jz@bp.renesas.com>
 <20230516064304.cdiifro7lb7ne2jp@pengutronix.de>
 <OS0PR01MB592277041AD411D212853FF586799@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB59221BF4B6ADC538CFE3BC8786439@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230522074830.fi2zciilwv236jgq@pengutronix.de>
In-Reply-To: <20230522074830.fi2zciilwv236jgq@pengutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10915:EE_
x-ms-office365-filtering-correlation-id: 78053cdc-9970-4504-bb71-08db5a9b77e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XqYoiYRWf1hDGSRcAuc4TsV2M9OplOcLJlp0tEHKa1FZk1hC/LlCO4iwNQxSjE8bcgc1i2c1pUVU4OJDLFVsfDrx0VOZXl5Q/VIfOQAoWmWK3/J0gJZLJ4xn70BS7CqT67qJhoEKJqzrz2jhTU2p1YCC4jKaUJw9AoHFbYvxB7rPlC/UhCdwyGG6VmXrTVGlqOzoK7ZH3OT4BC2iJnzs83cy7xsM7xFj+iMCQ+Tqx/73GB8zHCYb9vNxvj+2rhK7YBsu8H9FXcKfl9RQKQ1c1mPa1/QPlvujk0I6+KZQvQpubkTtx8kPqm/4FBBRm9VooKcMsbikeMxiH/s7/UWpEl3O6sDDtZp47XMKVzvvMFqNSarX3H1mkbu2Ykiuj4NtPAKiOb/Eit8QGPVBg2aXjXjtgbQyw6jvjnYIy0nPXfen8AoM3Yv+CZfJVjuBabdH9IGvJdvmASw6Ukou9a4YFetrR/Jtdu7ueYo6cmbe3m5GQRT348GinuPdsqoifC58peQyJr0o0x5NYOfqW+m5SagV+9z/jZzLCwKs/rjF9ydidFwBA2UFRONwBgTn+zAvU77igpX40IFLttoI50TAW1dx2Zv9osE7iWdfuwKdS3MbwP05cMWdmSC5HkZtLCQAUTuedh5+Ub+d80mH8FT3mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(83380400001)(66574015)(186003)(2906002)(38100700002)(86362001)(33656002)(38070700005)(122000001)(55016003)(52536014)(5660300002)(8676002)(8936002)(54906003)(6916009)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(7696005)(41300700001)(478600001)(316002)(71200400001)(9686003)(53546011)(6506007)(26005)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7kXWGNt4ek2TTvvyYmCdW/xLdRNRmFSnBitbEaUY46cW3SSFnBJCae8j9E?=
 =?iso-8859-1?Q?DmqEmH4il+4mD3VEyOCP3Dt06pNmZ+bX/AApulvDqOYRXWPGyECnatvZr0?=
 =?iso-8859-1?Q?AfsEwCbYZB3u2SK8F91RvmFJjP/ODNV0Xb+DFfE8QH7H7Z4mx9t6aQk95W?=
 =?iso-8859-1?Q?/U/AoeVbSs6oU6SU3pJrKfD0zMbyZMO1UG+2FvbZ0k1LqlMm9pMb3HzUHQ?=
 =?iso-8859-1?Q?qToZhzU9zbt9wSD4Tdp74vulv/mu5LQWVyPXLNTl3Qr6HbwTDOIX8RNy6c?=
 =?iso-8859-1?Q?OlSMCqAVxWAvqVqVqDzWL74bj2i/rFhDfx5yFqla7THaSX9pu9KpUSXCEb?=
 =?iso-8859-1?Q?/t7D5lTXVZ2Gis0NRTEnsZud6VBnMX3/wQ2mlF2xc1GRlN4dDpOHO5jRFB?=
 =?iso-8859-1?Q?6PT2NtuTDjRrV/DrIM4mZnRjLZC57dJNu0TIhYt/iyN/kovZpfArWCrY+Z?=
 =?iso-8859-1?Q?u1Y2hd77iwnrqv/1t1qBO0Whr73we9mVHV0Nmjip94gO5sDAQ5iHcpWAcu?=
 =?iso-8859-1?Q?qO9qC1VVI1vnZ6BR4E5wGhISPnWGH0rSBHwQFjO+pkUs9z528hds6zZMvn?=
 =?iso-8859-1?Q?mCR2s178PQJj948l/Wu+Tqi3PsNwJABASC3sANJdVBAIxZjzGzm44xth6g?=
 =?iso-8859-1?Q?bpH2D+CM5/PUJc3gPNndBYzMdL8bkVGQv5YZFA3mvlqsNpB3SKGv9/VMct?=
 =?iso-8859-1?Q?bQ/pl9S/B8VgqIzx2gxbtBY2GLxT+YIAJad9lVf+2bXCE3cEZs/grvZaI6?=
 =?iso-8859-1?Q?LH+81QZ29cBtfFCRURgTReJ6W2QShG1aAEfGAamxSorlrtTng36FAJp5u4?=
 =?iso-8859-1?Q?UBA30qKdZr6yrpxfyk0U2GgSSoHuLLt9Hm/aE20RKYfgiMg2fnMw/FyMQz?=
 =?iso-8859-1?Q?YCBG4Kmg+apDT0JvvnijKrF2aKWdk81V4HAnPAKSncz6LWl/zHmcsevM4t?=
 =?iso-8859-1?Q?hJR2iprb03MAXUBYLSB3rZDuBO79YEdfe91qb3La0Vlyt4ec6sz1vqovW6?=
 =?iso-8859-1?Q?P7/QdTFxFoghPl85VjB49o6dEpClwqv74H4jDTNRBT5p2lmcowD7hKzYQu?=
 =?iso-8859-1?Q?hkcpzG3/efBS3Xu5MrRHM5J8S61VGPXMnqtB3TRYT8OHH9nwD3GcL6JZNy?=
 =?iso-8859-1?Q?G5RMdeCT1LvJlMVBEwJA2Y3lukwj+MeX13W9O79ghql376iN+75wypJ8hB?=
 =?iso-8859-1?Q?lIG4Dsqe2+Pb7/Z91yQvXn74YEx7wsqrfLWurzqkuDQao7ZcoGAgObsn9g?=
 =?iso-8859-1?Q?IZ/GHQg3AA80/TpeVCDQ3M73lSQ1UqAuMFY5L1ZBtCUH4phuMI0GW+of5W?=
 =?iso-8859-1?Q?Y9JY00qO2+IX79sEa7JV698Yn5IyhKLsMzf4IJwZ37eTERTmnGNSHURfL4?=
 =?iso-8859-1?Q?KASz/CcHQtcJBfxjX+4nC5POs8I6dHVIXKX4hMGPF34tZMmA5782Pwy57d?=
 =?iso-8859-1?Q?jNLY5tEGlAwmoRnTq05n9hYPoC6jWmIpniyR4AXc01l+43ckOi1e+vYJLo?=
 =?iso-8859-1?Q?LkFPXu3zQogvdXvXqzE6N+oDD8VSSVEvcmgVaI9PRb90DVEw86OIxJWUYf?=
 =?iso-8859-1?Q?y9ksRtB0SpjmbPIqnKf3OkguD99wg9pOP9Gg2Sg/96DBRar7lZ2pSEoQqW?=
 =?iso-8859-1?Q?2TTlaYFtCei+Skojhyi7owcmpesVWdwL6y?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78053cdc-9970-4504-bb71-08db5a9b77e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 08:06:38.0765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vb2k7LBBpm4lPfbeIqnbV+xHA+gTzKXgs1A4Dscghtdr6sGe1XXc3HBAHAl7UxUqqq4SFA535Ve1/4evnAo4Gvs1dneWWteB7Id9Pwnz3QU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10915
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> > > -----Original Message-----
> > > From: Biju Das
> > > Sent: Tuesday, May 16, 2023 9:15 AM
> > > To: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Cc: Thierry Reding <thierry.reding@gmail.com>; linux-
> > > pwm@vger.kernel.org; Geert Uytterhoeven <geert+renesas@glider.be>;
> > > Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> > > linux- renesas-soc@vger.kernel.org
> > > Subject: RE: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
> > >
> > > Hi Uwe,
> > >
> > > Thanks for the feedback.
> > >
> > > > Subject: Re: [PATCH v16] pwm: Add Renesas RZ/G2L MTU3a PWM driver
> > > >
> > > > Hello Biju,
> > > >
> > > > here now comes my promised review. Took a bit longer than
> > > > anticipated, sorry for that.
> > >
> > > I know you are busy with "Convert to platform remove callback
> > > returning void".
> > >
> > > >
> > > > On Tue, Apr 18, 2023 at 11:20:37AM +0100, Biju Das wrote:
> > > > > +static u8 rz_mtu3_pwm_calculate_prescale(struct
> > > > > +rz_mtu3_pwm_chip
> > > > *rz_mtu3,
> > > > > +					 u64 period_cycles)
> > > > > +{
> > > > > +	u32 prescaled_period_cycles;
> > > > > +	u8 prescale;
> > > > > +
> > > > > +	prescaled_period_cycles =3D period_cycles >> 16;
> > > > > +	if (prescaled_period_cycles >=3D 16)
> > > > > +		prescale =3D 3;
> > > > > +	else
> > > > > +		prescale =3D (fls(prescaled_period_cycles) + 1) / 2;
> > > > > +
> > > > > +	return prescale;
> > > >
> > > > That value is supposed to be written to RZ_MTU3_TCR_TPCS, right?
> > > > This is a 3bit register field and in .get_state() you handle
> > > > values up to 7. I wonder why the max here is 3 only.
> > >
> > > I thought, for the initial basic driver, support bit values {0, 1,
> > > 2, 3} as It is same for all MTU channels and later plan to support
> > > the complicated external and internal clocks as it different for
> > > each channels.
> >
> > Shall I add this in limitations section, so that limitation is clear
> > to everyone?? And then send V17, as it is only the open point.
>=20
> I'd put it in a comment in rz_mtu3_pwm_calculate_prescale, for the
> general overview it's not that important I guess.

OK will add a comment in rz_mtu3_pwm_calculate_prescale.
Yes, for initial basic driver support this is not important.

>=20
> > I am planning to change non-error check version "pm_runtime_get_sync"
> > to error check version "pm_runtime_resume_and_get()" as you suggested.
>=20
> I didn't check the details here, but note that in .remove()
> pm_runtime_resume_and_get() is probably wrong. See for example commit
> 9496fffcb28f39e0352779a0199b6e61861c9221.

We are not calling pm_runtime_resume_and_get() in remove. Probably it shoul=
d be ok.

Cheers,
Biju

