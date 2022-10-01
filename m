Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1E5F1EF7
	for <lists+linux-pwm@lfdr.de>; Sat,  1 Oct 2022 21:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJATVc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 1 Oct 2022 15:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJATVb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 1 Oct 2022 15:21:31 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2098.outbound.protection.outlook.com [40.107.113.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE7533427;
        Sat,  1 Oct 2022 12:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnTmKGipEgyk68mFLaBvpvBQMRNaIruU+S5E5GBgg+6T4k/hqU0aIXicQXfb1SRHlt4+GqJMxoKTboO9jr56kqbnDpWk8OFidT1XgPto2hv/YhVQz7juh8YkHgB2+BnRokNy6qNOMiVqqSZjej5QrR8cv16G+x0KkxPQXS+oItDkfwYHD/ZA1ejaZ7MuJe79TWeH7lFJl/c7Dlw/OdYCmSeJ2etl+n+qWEKV3F9eiI1Zcy0CYjLXkf+EzMlBhfE3qUNTKivvlVYGtA4ZkwsV1d5QWchCG2zLcZrNca5EzJu+xO+X2I7lPoT/bXq8k3SlDsbskx9JYYu94D1XuiDzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4+fTxcHN1Ixrjl3Wp5CKROxRuAMbX0McmiLXwgeZpo=;
 b=RvgKvVwIEVsKSJ9QVwuk2pKSqSzyqfMe0CEwj34L7Y0mvL1lMapS2agXQNGUW0GkwR4Dkd926ehVMVY8yNfCX7owwBEY459PEUAtPYj1fVFidOJJ0VIi/YHAUVezZ2iDnGC/N4IMJmh9Eelj95HhlrtWu0DAwF/IkfNK7OK+GbFi+jBn2+2vICav+7j96IehXrrEs0LVBj/d9DZ1Tr0OXH9iASTv2IGDlYHBj1o77gUGZ0xdr+3dxTr0oGQUje6MTQAC+rhanJG3wRYB39reGu22QdtWgWGSQcb7SkVIhtfDIbTLrVJLDpaSIE5m6IQA5yb655TjHF3vsU2Y6bFqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4+fTxcHN1Ixrjl3Wp5CKROxRuAMbX0McmiLXwgeZpo=;
 b=ZFYiwW4scsloT+z/KYp5TczQzh/HZNMzToS1TrrcvHmJQOwI9aeAtI1LzkcBf1nzN7TWkJl7r6QRpfqICqW3EGkbeX3q5G9C7arar/fCOShG4emSz+pqbrEQ4ee0iVIANap5AeQ6fSWHzI2Vf2SpDp4Uyy3R8jYDVcVepvQJh6M=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB8503.jpnprd01.prod.outlook.com (2603:1096:400:15d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Sat, 1 Oct
 2022 19:21:26 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.026; Sat, 1 Oct 2022
 19:21:26 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     William Breathitt Gray <wbg@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Thread-Topic: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Thread-Index: AQHY0arfC6iQwXKfcEeqoNkH1bZYIq3z1zkAgACGWoCABD8nAIABKKwQgAAHVwCAAAESkIAACY4AgAABz8CAAAyBgIAAAxKwgAAFFwCAAAOJ0A==
Date:   Sat, 1 Oct 2022 19:21:26 +0000
Message-ID: <OS0PR01MB59223F69EA3215528519F49086599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <YzNztKSYQPQrnV7k@fedora>
 <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzd0YAWG/W9RNLQA@ishi>
 <OS0PR01MB59225B1CA8935C958BBA8AA186599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzhzZiZYEKuVX3eZ@fedora>
 <OS0PR01MB5922421ED17EEF758C6C319586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzh8ULruBgN1tf+L@fedora>
 <OS0PR01MB59225D16A182A4ECFC3A266586599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YziIUV3tyPd0GrFf@fedora>
 <OS0PR01MB5922F041D9C6EB2EBB9F8C8C86599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YziPKgPOx1/WUE5Z@fedora>
In-Reply-To: <YziPKgPOx1/WUE5Z@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB8503:EE_
x-ms-office365-filtering-correlation-id: 4c3d8b87-ed63-47b0-e4e0-08daa3e222b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gDAjCl/dnEvurjIVKAuJtqOwU323GBbZCWI5je86KUB7N8oeZw2hLTHkRLkesDCVPXoygqbxerRMpgZlS7Txj1WbJC+VdsEgRXo5hKiFqhY6kXb9bzXJeQXO7YUJvVxX1Y7HLKF7kCY7yyPl1dTFKrAN7POR5IKyidzhoiXCGhAmLiZ20/JgTLYeVZv5QOxcCZ+YaOxyWJTVqKLSCzfmNhndaU7yRu7/Id5gvArG7y53W0LSH8iR8DsOeNtkO1mUzSe97w1kjI8uh7unh+1qgv1wHXTbUmENNwZJUhkaBzUcigoAoK1b5p4lfjbOK3xfMA++s1fcLANff9dBWryZ69VqrSyWDrJ5MA5eC8HfgXkDt8MFzJgg+D/o1v+uAgGswOAj8J2cR8ehoBkrDpAfSSS62cqshmZVfo87GXDz+hdVyijs9vR7XIcjdhA6JGTKg2NFU/UsHhdiT+NiOl38MKDOJlXscianjAS6Zdbdl1Hnx3kxReMS3WfNqc91fsEQ6ylcNCBCV1vt4IXhH2nDotof1nf1rtSkX4pTvr6v0wmdRmpAd2QLjWOoBPvipEO/ITHu/grRADS2Dazeusjeu+aWAYkZ6zfcaW409PsTaqTYL2Vza6Zi3A0E1RWQyWQq01KSv+a2ELtA5qtuuBGIaq7rwCkjAllIOIQHrgJJvGzhD3zt74etnXCtDlPis3Sod78SZl7Uzsla4PaulsB9DcfPLeg8p97BicNOUBMmCsTMZrWWR5pt2fjKiLdNab8v3ak1XzRJBjJhRTIdXnrFroLuZNwSnDr7sWtNBW8hkxc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199015)(8936002)(52536014)(7416002)(5660300002)(2906002)(41300700001)(71200400001)(6916009)(54906003)(76116006)(4326008)(122000001)(8676002)(9686003)(26005)(478600001)(66556008)(66476007)(66946007)(316002)(6506007)(7696005)(64756008)(66446008)(38100700002)(33656002)(55016003)(186003)(38070700005)(86362001)(83380400001)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AqnwM7LY1qF7m1DpsP7Y/rZhowXeU6S3aRTNqyH78a0RUwQCR0wqUggPS2?=
 =?iso-8859-1?Q?yudHOtsDrr3U23ItXrvr2vNKrjmmb2V3yoVG/lLgsSzuV1nLIyfWBYR/w6?=
 =?iso-8859-1?Q?mQUdDDqJ4qC3Ldr9+d7znX9LWWs0f0XXl/CBoMhBtInfbX1qDaGLN9GC5T?=
 =?iso-8859-1?Q?XfpxWolRg2K9/BU1Y/sJaah6msdwPBh0CLhnVErmEuc6lNQTNyeFbB7Wj2?=
 =?iso-8859-1?Q?BPizJV4GXrsOsjV1tcz1586vnrn8PnUkiXcs+5LttJRmi9irNxFsLz4vEk?=
 =?iso-8859-1?Q?1H8pJQNh7Eszqg9NJwrT1GsHwuR7j1WBsffGlLI/EH+gqY3KBFi9bSn8wM?=
 =?iso-8859-1?Q?iS88YXg/8Ji2VXfFfkdNC8Tw5HT3kintDrr4xGSA8CI9VQJL1cfAUCzWYm?=
 =?iso-8859-1?Q?BBgdm/T7RYGZNHhPQmZLZB42eBR/t+5OQrV6kc9XdnkdKfDyJnLDspCfHw?=
 =?iso-8859-1?Q?0feBbT8rE7JgzZ8kVEJdoSa4w3U51bEDvq6N5loKOyTc8+3fF01QN39w+P?=
 =?iso-8859-1?Q?lY2HGD3ib7B/a946eNfdsmEVj1axvEsE91FdUerwJgOpPk4AUHp+RWuw/g?=
 =?iso-8859-1?Q?3ZqQ2NaBWwoaB97TJFLw0GNMiHcvFZyqZvgtANW5eijCMwNhAhbdgUrUnb?=
 =?iso-8859-1?Q?A0CDHcq6grABS8NhwwDe2G8+ENnNfL9w+d/ehODMAU4dW6TgBpm7zcoVvZ?=
 =?iso-8859-1?Q?rMzJOGhLD8u9rlYqDuM/pPX3Q450HFTuD4XI1sXE2r2GNgnCKE3rmoIgfg?=
 =?iso-8859-1?Q?nBTfLrmYLwJHv+DL6e4XRqee0mut6/G+L3TCJ1pQETIfuHLSACSYwoZGmS?=
 =?iso-8859-1?Q?tAt3Qpp0qzz5sv5UBgy0XA5MiUh/Rwk6h8AwBPTQd73IAAP0R/XMK4zN7s?=
 =?iso-8859-1?Q?Gn8QkSimOG/UXwHnF4Mg9DH8OaBQ/ZKd1/wE1kGjKy1g4XIKicPdCtXKX0?=
 =?iso-8859-1?Q?E55vT4iiKr1Kfen4JM0Esph9TVjhjBfbyaKXOpkIbAPmn6da2lRs6ApTd8?=
 =?iso-8859-1?Q?c+iDObkTPXxOoPO5ubpkp8MfRfwHX+0sGETW3QQgTRJwULf5V5eqGUW2eu?=
 =?iso-8859-1?Q?FU9z6a1RHgkFmNI9kbaC69VqcrBaxaDOSlYe4hKxIvDbFpg4D1RnIb6r7U?=
 =?iso-8859-1?Q?8fu2Ech2Rx3Pqj/hvvuN43YIC/xGjOMkWL9OT2llNa0TD05NseP7+lH/Ai?=
 =?iso-8859-1?Q?MmahdYZjlQnv/8nIqwU1/XDTO6k3nramwc+ae2IUB8CieSEdRRDmrV2CmI?=
 =?iso-8859-1?Q?Bg4vl54s9bvkzJfNsBxuO1SN1ESalbZXKHFWm9Bc3FPNGojnpcrw/PCtUi?=
 =?iso-8859-1?Q?kN+pg6sOftCKQSbv59HzPNuyhWlkWF3TpNakEGgNkVDiON318Cg7DDHOdz?=
 =?iso-8859-1?Q?2ExVWuTXlVrOQyibUM6AdXpWgT1bo+3czIUB1ijrXGW+X6sJipmS5lHgOE?=
 =?iso-8859-1?Q?SZ1aEvGsLesYbJh9DCczE8XQNSLth5zv3gp01SGqY7KVstEmnmIi3VYZuq?=
 =?iso-8859-1?Q?96/z/Sbbl6hLF3MP/9V31w8MLGcR/VEfPavNdeslSMEOzH75/lcSNsXTru?=
 =?iso-8859-1?Q?S9Ahv3CQlgp5ZKs6M62li9b8GoNgDHx2J+QN5VIl1X33bc6xOtyIyul2W7?=
 =?iso-8859-1?Q?yuDizfrbihOTntRssXgq0QAgnJzAp2S3Yg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3d8b87-ed63-47b0-e4e0-08daa3e222b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2022 19:21:26.6603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7+UBYZi82a4Yk7yWORlr7aQdVAAcPic5TkmiumC3qN7TMdRfT3TD45cszClOvqJk1CfhhK1WPdMaJAnmTTwS6ol2/fhvWNJwxHdUynw9Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8503
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
>=20
> On Sat, Oct 01, 2022 at 06:51:48PM +0000, Biju Das wrote:
> > > On Sat, Oct 01, 2022 at 06:03:37PM +0000, Biju Das wrote:
> > > > > What is the configuration when 32-bit phase counting mode is
> > > selected?
> > > >
> > > > LWA Bit (MTU1/MTU2 Combination Longword Access Control) needs to
> > > > set
> > > for 32-bit phase counting mode.
> > > >
> > > > b0 LWA 0 R/W MTU1/MTU2 Combination Longword Access Control
> > > > 0: 16-bit access is enabled.
> > > > 1: 32-bit access is enabled.
> > > >
> > > > > Does MTCLKA and MTCLKB serve as the counting signals in this
> > > > > case,
> > > >
> > > > For 16-bit and 32-bit counting signals same. We can set
> > > >
> > > > 1) MTU 1 and MTU2 signals as MTCLKA and MTCLKB
> > > >
> > > > Or
> > > >
> > > > 2) MTU 1 signal as MTCLKA and MTCLKB and MTU2 signals as MTCLKC
> > > > and MTCLKD
> > >
> > > I'm having trouble understanding this case. If 32-bit access is
> > > enabled by setting the LWA bit, and the MTU1 signals are
> configured
> > > as MTCLKA and MTCLKB while at the same time the MTU2 signals are
> > > configured as MTCLKC and MTCLKD, how is the 32-bit count value
> > > determined -- wouldn't
> > > MTU1 and MTU2 be counting independently if they each had separate
> > > input clocks fed to them?
> >
> > It is taken care by the HW. We just configure the register as
> > mentioned below and hardware provide counter values once feeding the
> > signals to either {MTCLKA and MTCLKB} for both MTU1 and  MTU2
> >
> > or
> >
> > MTU1{MTCLKA and MTCLKB} and MTU2{MTCLKC and MTCLKD}
> >
> > The signal feeding is same for 16-bit and 32-bit phase modes.
> >
> > Note:- I haven't tested 32-bit mode yet.
> >
> > Cheers,
> > Biju
>=20
> I'm not quite grokking it yet, but I'll trust that you're right for
> now.
> I suspect it'll make more sense to me once your next revision is
> submitted and I've had time to evaluate the code more closely.

OK, softwarewise we don't need to anything for 16-bit and 32-bit=20
as HW provide separate registers for accessing 32-bit counter values
eventhoug internally, it is formed by combining 2 16-bit counters on
MTU1 and MTU2.

OK, we will have more idea when I submit patches for 32-bit mode.

Cheers,
Biju


>=20
> Thanks,
>=20
> William Breathitt Gray
>=20
> >
> > >
> > > >
> > > >
> > > > b1 PHCKSEL 1 R/W External Input Phase Clock Select Selects the
> > > > external clock pin for phase counting mode.
> > > > 0: MTCLKA and MTCLKB are selected for the external phase clock.
> > > > 1: MTCLKC and MTCLKD are selected for the external phase clock
> > > >
> > > > > with overflows on the MTU1 register incrementing the MTU2
> > > register?
> > > >
> > > > No. that won't happen as we need to use different register for
> > > > Long word access
> > > >
> > > > These are the regiters used
> > > > 16-bit:- TCNT{MTU1,MTU2}, TGRA{MTU1,MTU2},  and TGRB{MTU1,MTU2},
> > > > 32-bit:- MTU1.TCNT_1_LW, MTU1.TGRA_1_LW and MTU1.TGRB_1_LW
> > > >
> > > > Counter in MTU1   MTU1.TCNT Word MTU1.TCNT_1_LW Longword
> > > > Counter in MTU2   MTU2.TCNT Word
> > > >
> > > > General register A in MTU1 MTU1.TGRA Word MTU1.TGRA_1_LW
> Longword
> > > > General register A in MTU2 MTU2.TGRA Word
> > > >
> > > > General register B in MTU1 MTU1.TGRB Word MTU1.TGRB_1_LW
> Longword
> > > > General register B in MTU2 MTU2.TGRB Word
> > > >
> > > > Cheers,
> > > > Biju
