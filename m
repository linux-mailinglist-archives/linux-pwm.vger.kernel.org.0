Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BDD697C81
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Feb 2023 13:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjBOM7O (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Feb 2023 07:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjBOM7M (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 15 Feb 2023 07:59:12 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2119.outbound.protection.outlook.com [40.107.215.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8BC31E33;
        Wed, 15 Feb 2023 04:58:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxaH/5grSpilAliCSq0R7SggkF72zGkKI9uRBgBFbnhirH5CaAjqq8kNXHDA+wREn/jyBjkWOl+xJ4K7G+sheX73ODHff4vTSulSiJe6UCX7lGApNOC7poPy90DqmHJpattsVtg6d+RAJZzyEWig1H53TCAxERjupZmPC4SuBNCTYqLuia60LbcGkEFf5VQ/UuVQlVYHhVlC98oOzk1rPReefIXEmS1yr55ihX0ZEZIQMHXwGGFUHKW+hQMkERlAjkdIlkll2ogdDp5CRUKmxKf24AxWoHFHsXpUIkfA8rBAkSY3/PsIWiRjN7SyzKRPnuYO4U09+PG72Vjw+TphIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLBNsHYfDzCGflbUHGQRPKtBZIEOc1JB5xrIBqO66uE=;
 b=Fn16LktlRdWMOvus/8oLnGgIh8qN6Ys5Nfu9Ypzj7x4MDimhhxKJZkbqly50bpKn4FgDz6WzWjtGAGK3jO/eEvo8P3584JBH3NS5nIzLszBuuiPN42C7611ibfgnprTNGrEu5K8dW9ACG+tLIZCf//ZZJgD8MWu1YVBNO7y9qyMaLHlKzNxWVBxAzxriTRn80EaxznhenSToVAK9GqTrf1htzaVDYHB+jfwnewL99i/DsWt3L/kDl9/5G4p6321VB7vcmYNF58xVTZTQqBAImOIX/6hj8Ny+sddnbL6bXBaIbtr7RXpPZV3If5sP/ROS60XzCLLiQHP3LcKHZYMAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLBNsHYfDzCGflbUHGQRPKtBZIEOc1JB5xrIBqO66uE=;
 b=Kf7Sa3L4CrZ3kuY1nZpA+vYqF4VpcHCtW/8xLtcFiu+85J0Blac5pexCSvAx6nD86Xt2tXcG3pPm3xwgXMUtjS+WfSZWDZRl/x4MUaYCKHs/t4P5lXDCIywVX7btfsxMs0OIkGvwNEc1VSmOYFVrSs9Ga0vrCpKaTEIfboGR3gA=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB6210.jpnprd01.prod.outlook.com (2603:1096:604:f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 12:58:50 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::343d:7339:78e5:a46e%8]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 12:58:50 +0000
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
Subject: RE: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Topic: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
Thread-Index: AQHZNyeGRDPllAbhcUe4ZTYF3l33467PwT+AgAAWbpCAABKdgIAAB63QgAAYVVA=
Date:   Wed, 15 Feb 2023 12:58:50 +0000
Message-ID: <OS0PR01MB592261AB4099B67478B49B0186A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230202165732.305650-1-biju.das.jz@bp.renesas.com>
 <20230202165732.305650-7-biju.das.jz@bp.renesas.com>
 <20230215083037.ivlmqhp4xngnexca@pengutronix.de>
 <OS0PR01MB59227E0E659C292D775474BF86A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <20230215105731.4yhwgdbux7mogf4j@pengutronix.de>
 <OS0PR01MB5922CDACE9490271D222340386A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922CDACE9490271D222340386A39@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB6210:EE_
x-ms-office365-filtering-correlation-id: c75996ab-d6b7-4dc4-5340-08db0f546231
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvxNWwbhpVCVZJU1c5LQarJ+JS0q9Vmtm2Wx+vz2PWY6JDv2oPcrqL3yrgBjGywkJpJxNNWvt7BqeJf4CtK2I9jQx9quM14qd266hrrWFVgjjPIlEFXeiAd6fQjiLy9GsvM6I9IpPYyTRm8EE8u/4cNfommgQcaVayEAXdMrVXsfox62wbRUopGjuzh0AkTVurQ38jGJZiPu7gDzQjoT9VQSBFiX3FzrkpR6jq8xcTP8zSIozkQPhH3jBiG+FlZ7PZAh0DObuRgkm3kQ/BTnZXUqLra0g8r4WC1ElgOM4qNFuSTK9ioHNJxwHVbs/lGJ1kNh5zW9zs3CT5OXImjuuuJCnGBP2YQCTwY4tWbJMQdcZJKBCOft4hOXTX6cn0bs1/vEVCIrYWlQrWW3J2JN8S85J2LYeTCWi02bnQYfEK45ndxPj24fdVW+3jrny4oHr93m6iAEFsJo/T9viAFg02N8upv5KWdJLKjWCKQWr2zNfjs5flhgh+HJtzGZQi6MvhIdX6uXdGz+NXRzf75BO+SxRAm/iLhfpDQkn2Wcn46mcW5wD9MWHMT72gwTQY44hzxs+e5Wer/qSfl0lXLvyEAcP63+GVsZe1g3XDVvdZ06XQ1N9GuohKPnhGV14y3kpxqBn8gpBXKSLI5g8vIy3r5ILOHgda+j0ThZITQ9L1rByFP3xEwOgPh0jnU57/ZCPLGpSLKBIr4MSuE7p10v6Jq5LZt+v4z1R9fdkdec4Uw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199018)(6916009)(8676002)(66946007)(55016003)(4326008)(66556008)(66446008)(64756008)(66476007)(76116006)(41300700001)(316002)(8936002)(54906003)(52536014)(83380400001)(71200400001)(2906002)(33656002)(7696005)(5660300002)(38070700005)(86362001)(26005)(478600001)(186003)(6506007)(9686003)(38100700002)(122000001)(2940100002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pbTSJ0EfomyqzT4m7b8gn5GnLH8wm06qRSHnidJ1iM3WPtLAoTqmBCDqXV?=
 =?iso-8859-1?Q?YDJSqFX8oXfeUvGh0pACC616aqjj+Y6F/u6xQ7CTslAu5Dm1VTo6wbcUtE?=
 =?iso-8859-1?Q?39boLm5jss5AvycIQJ5GUNdw+GIOZZ3VBsJmLLDcwSanpu+BC1cP7psdNU?=
 =?iso-8859-1?Q?qhiZdECPgCK5g8fEurJIrnV1Ib0XZH89zk6e0SZ2G/Q38tlFLFVgN0l1Oo?=
 =?iso-8859-1?Q?KJW/0kAPfQGA7pPS5oL2n9X/LHQ1aSoIsrlHy3tudtOWnvDJP/GebtOQ+m?=
 =?iso-8859-1?Q?brUo692ACpwKNcy4fuMof2z1I483/9YptRU7jxgB0rfOz9fB8PRD+D01EQ?=
 =?iso-8859-1?Q?n55MH8+OMV3MJmlhJNRc5Y16TcLpGbgCai+WfcVChRZzz40Awcl3VMBi4t?=
 =?iso-8859-1?Q?TWhqpm0Eg7YH3WR7zDM2onptwSePVR+ljUj7zUSYPQGYD4QO2irtUCw+Bk?=
 =?iso-8859-1?Q?T4gtJj0RTvOuYMzTwJe6Aty7hlCY1SLhlyfC0YEI1JknSxJXUTbjm3P8o5?=
 =?iso-8859-1?Q?laINEnWwnN8Tj7biXGpSET2wDw4A/ttvYa/1L1Ue5u1bNfN9sRQSWvGOwG?=
 =?iso-8859-1?Q?d65znEEcpPKp9ndrqo/NQPMo6YP3jnrednSMSpUCm+OgOuCMfAz4IUT7FV?=
 =?iso-8859-1?Q?eOC9SPrdBLiRizOEFZJAOwhEXaz6CKdiualmoQyNoi1k7KRhxe2xbgFgt0?=
 =?iso-8859-1?Q?86qeLkXmAcA4ShL9EWjoudwdpQHZKlQXtOqKD2XvAeAdNcVlbpNeLEuDzq?=
 =?iso-8859-1?Q?BXqvKf1OhVxyF/e0YmsRXB53kzZEYOzCsvOKTY7DVkfzXZ11Z8PqkZxltJ?=
 =?iso-8859-1?Q?gtsjY9mmFg+6VqsKngCqgFrtzfGhb8RM5QLZm94F+fhpCetpMpS6fEKriC?=
 =?iso-8859-1?Q?zA/Zo735ZkMhjmZUfr+0nKquiZjCBKlXLV1hkYpUZ6SSq43JBZZ5UVMoi9?=
 =?iso-8859-1?Q?VA2NDAayUbhDiislUReh60vCAVgUc4dKNZx1CHX2/kOr+tXWD2XPBZmVZL?=
 =?iso-8859-1?Q?pS9LjSQ2O2pSm/bpct3vKtLAsuea9/8vfrrllWNYIwLydZtbiWP2o4R7hh?=
 =?iso-8859-1?Q?CJXrAMcR03ICLf5vB4uT14fEz1rTBVLMmz/IBFhsnVHc4jvaaZEITD2kS7?=
 =?iso-8859-1?Q?KEFxeLoklfiABILFyvT3AuiCf6CmAdzZDooOIIsdeJV0xPOuPywGDhbc8m?=
 =?iso-8859-1?Q?rXMLMiqqywjWmrYXnrCRYeU3R3p41xGYln1++q/5Q9QBNjCpBsBzCaWOaR?=
 =?iso-8859-1?Q?422x47FBMCvbgPlMLWSS+s88goiz+sjetsOTTwzozHXqbknHlRox3XXISv?=
 =?iso-8859-1?Q?d+1GvU2PxYQKtfN5I2wsmhkOCXUnEfCdPK2BN5HXXRts8+BVb3Kly1JOo2?=
 =?iso-8859-1?Q?y3iG730hKHbWfK7heOm3pgIIIs+DCGt2xxzUDc2015PMWENLGniFhGtK9j?=
 =?iso-8859-1?Q?h7+XoXhkmbaofR5f2/qZExey0jKokpDkpT175O1tiqS+JAIG6bNNpkbkWw?=
 =?iso-8859-1?Q?Oa0Omp2ZKvnF5DpcJ8ns0MPDQgTjVhlGqpomSgBg6UdBU11iTlBu0BPBAi?=
 =?iso-8859-1?Q?XSmZsMJlBu7NHJwlqt4tC3NrWisri1WlZ7LtvEkWnr+YC7lT2cDpOANHKY?=
 =?iso-8859-1?Q?6RXRap99F+rQyJyj5liEsPPxuhoXoyTO7WD81DyMlZgz3zpTnsWHYplg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75996ab-d6b7-4dc4-5340-08db0f546231
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 12:58:50.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VkVub/+/KbGxdTIQi8hwgKKCm5Zgd+eJsW7J1uco3HuMK3nPZ7mJtEuPBYRA5uXn5tPpMSRKkRttxnHBD+asUI8ydwHt4S3j97IQKJcraXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6210
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

> Subject: RE: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
>=20
> Hi Uwe,
>=20
> Thanks for feedback.
>=20
> > Subject: Re: [PATCH v12 6/6] pwm: Add Renesas RZ/G2L MTU3a PWM driver
> >
> > Hello Biju,
> >
> > On Wed, Feb 15, 2023 at 10:31:20AM +0000, Biju Das wrote:
> > > > On Thu, Feb 02, 2023 at 04:57:32PM +0000, Biju Das wrote:
> > > > > Add support for RZ/G2L MTU3a PWM driver. The IP supports
> > > > > following PWM modes
> > > > >
> > > > > 1) PWM mode{1,2}
> > > > > 2) Reset-synchronized PWM mode
> > > > > 3) Complementary PWM mode{1,2,3}
> > > >
> > > > It's unclear to me what "PWM mode1" and the other modes are. I
> > > > suspect this is some chip specific naming that isn't
> > > > understandable for outsiders? Would be great to explain that a bit
> more.
> > >
> > > I will give some details about PWM modes mentioned in the HW manual
> here.
> > > I will respond to other comments later.
> > >
> > > PWM Mode 1
> > > ------------
> > > n =3D {0,1,2,3,4,6,7}
> > > MTIOC0A:-MTU0 TGRA input capture input/output compare output/PWM
> > > output pin
> > > TGRA: Timer General Register A
> > > TIOR: Timer I/O control register
> > > In PWM mode 1, PWM waveforms in up to 12 phases can be output
> > >
> > > PWM waveforms are output from the MTIOCnA and MTIOCnC pins by
> > > pairing TGRA with TGRB and TGRC with TGRD. The levels specified by
> > > the TIOR.IOA[3:0] and IOC[3:0] bits are output from the MTIOCnA and
> > > MTIOCnC pins at compare matches A and C, and the level specified by
> > > the TIOR.IOB[3:0] and IOD[3:0] bits are output at compare matches B
> > > and D (n =3D 0 to 4, 6, 7). The initial output value is set in TGRA o=
r
> > > TGRC. If the values set in paired TGRs are identical, the output
> > > value
> > does not change even when a compare match occurs.
> > >
> > > PWM Mode 2
> > > ----------
> > > n =3D {0,1,2}
> > >
> > > PWM waveform output is generated using one TGR as the cycle register
> > > and the others as duty registers. The level specified in TIOR is
> > > output at
> > compare matches.
> > > Upon counter clearing by a cycle register compare match, the initial
> > > value set in TIOR is output from each pin. If the values set in the
> > > cycle and duty registers are identical, the output value does not
> > > change
> > even when a compare match occurs.
> > >
> > > In PWM mode 2, up to eight phases of PWM waveforms can be output
> > > when synchronous clearing is used as synchronous operation in the
> > > channels that cannot be placed in PWM mode 2.
> >
> > Why is PWM Mode 1 about two outputs? These could be abstracted as two
> > individual PWMs, couldn't they?

Yes, 2 outputs can be model as 2 individual PWM's.

 In this mode you could implement a
> > phase shift, but the period is limited to the overflow time of the time=
rs.

Yes, that is correct. For eg:- case MTU0

It has TGRA and TGRB -> MTIOC0A output (PWM0)

       TGRC and TGRD -> MTIOC0C output (PWM1)

By using these registers, we can implement phase shift.

Cheers,
Biju
