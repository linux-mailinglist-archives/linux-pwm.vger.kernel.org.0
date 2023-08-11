Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC55778C3F
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Aug 2023 12:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHKKrk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Aug 2023 06:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjHKKrj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Aug 2023 06:47:39 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2102.outbound.protection.outlook.com [40.107.7.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB6012C;
        Fri, 11 Aug 2023 03:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YihPLGkd52/6hCPXkxj1ihpvewawbcpytaD2+WQ8jUiNQoKv2Ml+wc0hGc+lyoD5fub8/QjGCjYTfgYgZkBiBHzVehwh6Z4N+UxhclLd9+Kjbdf8YlW8A71eY+DjJtKuv+OcI63LMO+fgTXtwapSVVvayuxAyq7GTNobUb8dBMwO4SdKOOwrahgNJNzP1KR4AFltbYpbmWenZARzPsI6FFkzMCwXjnESlXNk/xF0bP+CROSPSud4Hl5VwMFPRrjem2AwiCWRiWC3lmjUF/0ptvXUeL8qui5AWTuhe6XiyPWbi0ptjKLVNV9ErRdwL7Y0arzP0+pk/tjbf4x1ixEymQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNaSEVSu0r8MMjUvsHNhd9bWDy0rziW2NFPBSd8ipXM=;
 b=ceYIp1qnpCPS1nlF6XN6s4lyXNLbnwwdUua6Im00b8wX2BkDW8g0PLrmjYLcWFPaYcv6JjQ7ELa0dia3K4zzcrfFoqXxtG1n+ZlF3i0jBtKGkGpOAqttmYlB07WBFD0Ks+uhCvavt0ziZUl4pimGvs2qgTTs0DQF0o5GlkqtPlNV4TqmQYEowcqx6tQWYW8OSAQEOnZiq11fBimt6u/5ZTWHrCkjhukbUNVOXosklMj3Y0Hua3rs4CZEHobWfxXE9wM+gMbyT+kHU5ER4BxBaGDWT0u+9kWdrXA4lzCW9IreSjW1SNZuu1aZw1pu5krxDVDTZADPcCoWcngogJKR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNaSEVSu0r8MMjUvsHNhd9bWDy0rziW2NFPBSd8ipXM=;
 b=C2XzHchn/fu03wyGyRDOR5qvQ9uF/xQRBtbHNaHk2oS3IGBXIiKlUFzx/q2ZMlDUILbjApeRrc4e1pcZ2hkCy6t7oz04xrvncV7DiMTlgBIW4NuAQsMhBbwt+Mp7oZypVqtOA7RL29PuoNB09ViEf+arNydrtwXpBrC+sRXBofH4yVTY6w/tCG+jsI2cYMeRfSy3qKaFtyFp7XQlveQEbc0lVNvvFpsFBQgBOJEWk8ZvrnT/3mXE34w04Go6lZXWSYGc9tUPiosi1OPywKXhuXglMAS6XJNSUD7VS7mGnKYUmypMGBdc6kSneH5Ra9tbHi2StyrlYUAd0bZgGT6dYg==
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com (2603:10a6:20b:345::20)
 by AS1PR03MB8192.eurprd03.prod.outlook.com (2603:10a6:20b:483::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 10:47:34 +0000
Received: from AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::5663:2a6a:8708:b19e]) by AS8PR03MB7621.eurprd03.prod.outlook.com
 ([fe80::5663:2a6a:8708:b19e%4]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 10:47:34 +0000
From:   Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
To:     Takashi Iwai <tiwai@suse.de>, Jeff LaBundy <jeff@labundy.com>
CC:     Marek Vasut <marex@denx.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: RE: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Thread-Topic: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Thread-Index: AQHZzEE8ipoNlrMdu0itm5QWu4ZGQQ==
Date:   Fri, 11 Aug 2023 10:47:34 +0000
Message-ID: <AS8PR03MB7621C4E9B338259499AD24DBFA10A@AS8PR03MB7621.eurprd03.prod.outlook.com>
References: <63adce9a-df65-b462-9055-0ece5216d680@denx.de>
        <87tttkjmyu.wl-tiwai@suse.de>   <0cffe366-75af-d8a8-8920-6fb94c321a89@denx.de>
        <87h6pkjh7q.wl-tiwai@suse.de>   <618add56-3675-4efe-5b20-665c10040e03@denx.de>
        <ZMfgJ3o00nApkXGp@google.com>   <f4612dc5-a7d4-74ba-2ed8-ea70314625b6@denx.de>
        <ZMh0Sa9s25JHhWw5@nixie71>      <ZMi0HT/yaTo9uTyi@google.com>
        <d0f284d5-6922-ea3b-3447-c089b0d24587@denx.de>  <ZNW25qlzh8YbZtu8@nixie71>
 <87h6p6rp6k.wl-tiwai@suse.de>
In-Reply-To: <87h6p6rp6k.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ActionId=bf278e9d-d8cd-4802-9ce4-1738116b33d6;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_ContentBits=0;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Enabled=true;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Method=Standard;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_Name=Confidential;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SetDate=2023-08-11T10:45:19Z;MSIP_Label_af615ef3-aa90-4fa2-9d66-c4f70f9fc413_SiteId=fb4c0aee-6cd2-482f-a1a5-717e7c02496b;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB7621:EE_|AS1PR03MB8192:EE_
x-ms-office365-filtering-correlation-id: 5a59fe65-c00e-4a66-9967-08db9a585f22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cOxQrEFr67AkvvpFLvtIXFBFuHpK0C4j+uXNBQNb/X3DDK5sQyay7qw5h8BMU/V5X5hGHN8VnnmiCJn3xs/OkGTHj30HLQyDGS4UbVF0bn9ZGHVevZaN8qBSZSxW83VsrXkIQoZsi52+x4exEh2si9lQJPRSj6KDcHVb6h13H2MjPHIEeNldFDW2Vk0oYGJzzg13ndxWQsd61E+0z8Rv1JJioKDUZaTbWK7OZjO0+gv/9faOdOE51hGU9PZTjOKB9gOanwuYfnR8d/Pcdu8qhm6DWid4NvCMKOHXitpdx3uyx83/wK7xY5rH8eCcwEX9kvPEnQAwXNmNxt5BvFfymfMhPDD0iWUO5GAofkIVRVlbEJ4CYfXiJOZKFtPZAJWazheidG7WJWZ9BQy5p60pMkO2x6mWYOo0FgiETv0UyxsiWCi9CbESYEsmUs/yQU41r7UwFiRZFaAl3+XEXahQSqPjZtjjEkP6PHzYyv/y+8sEap7FAvQCx6wGLnE/yUXyYQvlBTFPyKkMgxmHb5xyOOvxOEZVnQlOrKG9SAarIUdim5FTilLT+tTcvkzPDgKqqcpoFBxgwH+JyFPZqX/qHZlw/9zqgaEJxIeO7yZHIcy14l7hUlTZzH4alcRD3iWX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB7621.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(396003)(136003)(1800799006)(186006)(451199021)(38100700002)(38070700005)(33656002)(86362001)(122000001)(55016003)(53546011)(71200400001)(54906003)(110136005)(7416002)(7696005)(64756008)(66476007)(66556008)(66446008)(4326008)(66946007)(5660300002)(41300700001)(52536014)(76116006)(478600001)(9686003)(26005)(316002)(8936002)(6506007)(2906002)(83380400001)(8676002)(30864003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3fb4YzjNVLCaLHKdDbByIz422DMEQAcn8B3MxEm5cYIRo8sSwEY+E2WTvS?=
 =?iso-8859-1?Q?JY4CMXETO8+aIDcF2HtCelgZr1401BSj/qeGM6NiwvL4Hg+uweOEAKvAEx?=
 =?iso-8859-1?Q?df8PCbG1JK6fWSsAUO4ANXhfm8Yt9QBM42yn8Z83v8KFRNVKLFn4nCsord?=
 =?iso-8859-1?Q?hGxbSuaBX6zqydmUs4F9WGfo7VCbcIoBar7zfzgm71U4N/JUerS87FvSUY?=
 =?iso-8859-1?Q?+ECWf7ey7bWQE8HXUDpS7foQOYl805q4rw710ud/7JBoYHvVl/sl0/XHCp?=
 =?iso-8859-1?Q?Shbemd6QzjObIi0GAxmnRzBQ8zsj9H0DsPRcn3K73iWcGJ0sm6mUd9pO2R?=
 =?iso-8859-1?Q?lcjXZI9KNAk9UHnQcTOEYkPas1ZwZ10PvcOceyCcnCDINa0HsmSa95Ga3k?=
 =?iso-8859-1?Q?6LnYTrv1rjKohVs71wS5lnO/TDSlHJ4f6ClNr+o5uOG1vxGRwPvR+GBQFd?=
 =?iso-8859-1?Q?AQY1HVrzjgSGhB1yy3X6aF8zWIqHTqB8TV9U4i4C/1ZNPWhxL8hB8VywQt?=
 =?iso-8859-1?Q?pB9fniX2xwc2x/YaYLaNzzCoYyrLu1pbNShaG4//EHkm/k6QgdsJSyWJQb?=
 =?iso-8859-1?Q?Qd6o5J4Rkio+y9Q4xUmmfDhWNLaBp1wCOseetbLXsK+qn9KAnbxLyFZ5Ap?=
 =?iso-8859-1?Q?OyYY6NlG5pOJ+hyt6rKZEnmRR6Rv0rMIFTbBdX066ELOUzqOpYKMgY9eex?=
 =?iso-8859-1?Q?gAGar1UNmw71yG8hI7JoVu0jK89GBfSpOpsuP1s/V26FldwwNZVHssDnr1?=
 =?iso-8859-1?Q?hbZyRJYdyNIWwsHs9w+UZ+ZD9x4508T9k7So2kLsh4E8BkKY65wb05g5Q+?=
 =?iso-8859-1?Q?ACIlAoM3yHcLKZh0w4QY4fJVBDvjQNDLy9JVM6rBdHOiEyy9eoGB6JJQu2?=
 =?iso-8859-1?Q?gDgSOEzASKmhYy8qj/cplLq+UDQM5a27TV3U1W0vxUx6Ym+yRtoJdgclOV?=
 =?iso-8859-1?Q?vExxkH6yhNAuMac7o4cooNOsO+LU6Ux4e2oaDpt/YpH7m6aB9Q6T4/9KOl?=
 =?iso-8859-1?Q?Ln/l21FTZzPNWpT1R/+ZUr8w/XUVV9lXik68nmFGcxV0O1gg34GloWgwDs?=
 =?iso-8859-1?Q?zhPi+NlaP05xHOfoc/RHL2HXchs8J3B4mAJtJBCV/YN4VbOHr7Lvdrn9gQ?=
 =?iso-8859-1?Q?EfK5Kb8BkFhVIhY06i1gHqBb8L623JwB4vXK4hEnvYz/5NInY7+BbbnBfX?=
 =?iso-8859-1?Q?qS0pH2NiNRlVWq+t5peErF8AHKe7zSCJaLfQoB/18t8mBO2SUNJ9v6PDcG?=
 =?iso-8859-1?Q?iqB3WFBceGyhtFPkNtNZcDiNQbfhmWNRjq3VShtI7hnEMJ+F5FgNh70QVQ?=
 =?iso-8859-1?Q?VbdCqQGJxMWY493DhYsFOV8gr29/XEazJ5NwfiOiAXSmZjcNwdwxwT7zN6?=
 =?iso-8859-1?Q?vURxStxaKdHrexmurKsjfSu86SETitFE6Q5BoOVuykO9kGAsmTJOTjzJZv?=
 =?iso-8859-1?Q?r31q9GmoiSGkYIVY/zGpKy/swYdKJDjDE3HWqeChgfKl0FICaPy5R/iBP5?=
 =?iso-8859-1?Q?0ONn3gYpZEorI4wpVow6JRd1JE8gNf/QvBtKOuD6XJ0afSRteWNcepbStI?=
 =?iso-8859-1?Q?PoIM2r0Ln4sINOnkI5RRFAYO35N34CZYHsJncoYXah2EAepLtJOfoOJIRs?=
 =?iso-8859-1?Q?i3XaZVpUoVvxl+IIDvG20rOcvsPBjNaYwZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB7621.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a59fe65-c00e-4a66-9967-08db9a585f22
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 10:47:34.6868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5DqQSZ02gv2DNGONWoYgHCr4qMj5IpabfuxmvJqBLp0hsEGdLaBxZVu+e+Bkiq4AG3zs1hv7PMyYVs7LfK/wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR03MB8192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi

> On Fri, 11 Aug 2023 06:19:50 +0200,
> Jeff LaBundy wrote:
> >
> > Hi Marek, Dmitry and Takashi,
> >
> > On Tue, Aug 01, 2023 at 01:51:50PM +0200, Marek Vasut wrote:
> > > On 8/1/23 09:28, Dmitry Torokhov wrote:
> > > > On Mon, Jul 31, 2023 at 09:56:09PM -0500, Jeff LaBundy wrote:
> > > > > Hi all,
> > > > >
> > > > > On Mon, Jul 31, 2023 at 07:49:50PM +0200, Marek Vasut wrote:
> > > > > > On 7/31/23 18:24, Dmitry Torokhov wrote:
> > > > > > > On Mon, Jul 31, 2023 at 04:36:01PM +0200, Marek Vasut wrote:
> > > > > > > > On 7/31/23 16:20, Takashi Iwai wrote:
> > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > > > > > > Uh, I don't need a full sound device to emit
> > > > > > > > > > > > beeps, that's not even possible with this hardware.
> > > > > > > > > > >
> > > > > > > > > > > Heh, I also don't recommend that route, either :)
> > > > > > > > > > > (Though, it must be possible to create a sound
> > > > > > > > > > > device with that beep control in theory)
> > > > > > > > > >
> > > > > > > > > > I mean, I can imagine one could possibly use PCM DMA
> > > > > > > > > > to cook samples to feed some of the PWM devices so
> > > > > > > > > > they could possibly be used to generate low quality
> > > > > > > > > > audio, as a weird limited DAC, but ... that's not reall=
y generic,
> and not what I want.
> > > > > > > > >
> > > > > > > > > Oh I see how the misunderstanding came; I didn't mean
> > > > > > > > > the PCM implementation like pcsp driver.  The pcsp
> > > > > > > > > driver is a real hack and it's there just for fun, not fo=
r any real
> practical use.
> > > > > > > >
> > > > > > > > Ah :)
> > > > > > > >
> > > > > > > > > What I meant was rather that you can create a sound
> > > > > > > > > device containing a mixer volume control that serves
> > > > > > > > > exactly like the sysfs or whatever other interface, witho=
ut any
> PCM stream or other interface.
> > > > > > > >
> > > > > > > > Ahhh, hum, I still feel like this might be a bit overkill h=
ere.
> > > > > > > >
> > > > > > > > > > > > I only need to control loudness of the beeper that
> > > > > > > > > > > > is controlled by PWM output. That's why I am
> > > > > > > > > > > > trying to extend the pwm-beeper driver, which
> > > > > > > > > > > > seems the best fit for such a device, it is only mi=
ssing this
> one feature (loudness control).
> > > > > > > > > > >
> > > > > > > > > > > So the question is what's expected from user-space
> > > > > > > > > > > POV.  If a more generic control of beep volume is
> > > > > > > > > > > required, e.g. for desktop-like usages, an implementa=
tion
> of sound driver wouldn't be too bad.
> > > > > > > > > > > OTOH, for other specific use-cases, it doesn't
> > > > > > > > > > > matter much in which interface it's implemented, and =
sysfs
> could be an easy choice.
> > > > > > > > > >
> > > > > > > > > > The whole discussion above has been exactly about
> > > > > > > > > > this. Basically the thing is, we can either have:
> > > > > > > > > > - SND_TONE (via some /dev/input/eventX) + sysfs volume
> control
> > > > > > > > > >      -> This is simple, but sounds racy between input
> > > > > > > > > > and sysfs accesses
> > > > > > > > >
> > > > > > > > > Hmm, how can it be racy if you do proper locking?
> > > > > > > >
> > > > > > > > I can imagine two applications can each grab one of the
> > > > > > > > controls and that makes the interface a bit not nice. That
> > > > > > > > would require extra synchronization in userspace and so on.
> > > > > > > >
> > > > > > > > > > - SND_TONE + SND_TONE_SET_VOLUME
> > > > > > > > > >      -> User needs to do two ioctls, hum
> > > > > > > > > > - some new SND_TONE_WITH_VOLUME
> > > > > > > > > >      -> Probably the best option, user sets both tone f=
requency
> and volume
> > > > > > > > > >         in one go, and it also only extends the IOCTL i=
nterface, so
> older
> > > > > > > > > >         userspace won't have issues
> > > > > > > > >
> > > > > > > > > Those are "extensions" I have mentioned, and I'm not a
> > > > > > > > > big fan for that, honestly speaking.
> > > > > > > > >
> > > > > > > > > The fact that the beep *output* stuff is provided by the
> > > > > > > > > *input* device is already confusing
> > > > > > > >
> > > > > > > > I agree, this confused me as well.
> > > > > > >
> > > > > > > This comes from the times when keyboards themselves were
> > > > > > > capable of emitting bells (SUN, DEC, etc). In hindsight it
> > > > > > > was not the best way of structuring things, same with the
> > > > > > > keyboard LEDs (that are now plugged into the LED subsystem, b=
ut
> still allow be driven through input).
> > > > > > >
> > > > > > > And in the same vein I wonder if we should bite the bullet
> > > > > > > and pay with a bit of complexity but move sound-related thing=
s to
> sound subsystem.
> > > > > >
> > > > > > I am not sure that's the right approach here, since the device
> > > > > > cannot do PCM playback, just bleeps.
> > > > > >
> > > > > > > > > (it was so just because of historical reason), and yet
> > > > > > > > > you start implementing more full-featured mixer control.
> > > > > > > > > I'd rather keep fingers away.
> > > > > > > > >
> > > > > > > > > Again, if user-space requires the compatible behavior
> > > > > > > > > like the existing desktop usages
> > > > > > > >
> > > > > > > > It does not. These pwm-beeper devices keep showing up in
> > > > > > > > various embedded devices these days.
> > > > > > > >
> > > > > > > > > , it can be implemented in a similar way like the
> > > > > > > > > existing ones; i.e. provide a mixer control with a
> > > > > > > > > proper sound device.  The sound device doesn't need to
> > > > > > > > > provide a PCM interface but just with a mixer interface.
> > > > > > > > >
> > > > > > > > > Or, if the purpose of your target device is a special
> > > > > > > > > usage, you don't need to consider too much about the
> > > > > > > > > existing interface, and try to keep the change as
> > > > > > > > > minimal as possible without too intrusive API changes.
> > > > > > > >
> > > > > > > > My use case is almost perfectly matched by the current
> > > > > > > > input pwm-beeper driver, the only missing bit is the
> > > > > > > > ability to control the loudness at runtime. I think adding
> > > > > > > > the SND_TONE_WITH_VOLUME parameter would cover it, with
> least intrusive API changes.
> > > > > > > >
> > > > > > > > The SND_TONE already supports configuring tone frequency
> > > > > > > > in Hz as its parameter. Since anything above 64 kHz is
> > > > > > > > certainly not hearable by humans, I would say the
> > > > > > > > SND_TONE_WITH_VOLUME could use 16 LSbits for frequency (so
> up to 65535 Hz , 0 is OFF), and 16 MSbits for volume .
> > > > > > > >
> > > > > > > > I'm hesitant to overcomplicate something which can
> > > > > > > > currently be controlled via single ioctl by pulling in soun=
d
> subsystem into the picture.
> > > > > > >
> > > > > > > Can you tell a bit more about your use case? What needs to
> > > > > > > control the volume of beeps? Is this the only source of sound=
s on
> the system?
> > > > > >
> > > > > > Custom user space application. The entire userspace is custom
> > > > > > built in this case.
> > > > > >
> > > > > > In this case, it is a single-use device (think e.g. the kind
> > > > > > of thermometer you stick in your ear when you're ill, to find o=
ut
> how warm you are).
> > > > > >
> > > > > > The beeper there is used to do just that, bleep (with
> > > > > > different frequencies to indicate different stuff), and that
> > > > > > works. What I need in addition to that is control the volume
> > > > > > of the bleeps from the application, so it isn't too noisy. And
> > > > > > that needs to be user-controllable at runtime, so not something=
 that
> goes in DT.
> > > > > >
> > > > > > Right now there is just the bleeper , yes.
> > > > >
> > > > > It sounds like we essentially need an option within pcsp to
> > > > > drive PWM instead of PCM, but input already has pwm-beeper; it
> > > > > seems harmless to gently extend the latter for this use-case as
> > > > > opposed to reworking the former.
> > > > >
> > > > > I agree that we should not invest too heavily in a legacy ABI,
> > > > > however something like SND_BELL_VOL seems like a low-cost
> > > > > addition that doesn't work against extending pcsp in the future.
> > > > > In fact, input already has precedent for this exact same thing
> > > > > by way of FF rumble effects, which are often PWM-based themselves=
.
> > > > >
> > > > > If SND_BELL_VOL or similar is not acceptable, then the original
> > > > > sysfs approach seems like the next-best compromise. My only
> > > > > issue with it was that I felt the range was not abstracted enough=
.
> > > >
> > > > If we want to extend the API we will need to define exactly how it
> > > > will all work. I.e. what happens if userspace mixes the old
> > > > SND_TONE and SND_BELL with the new SND_BELL_VOL or whatever.
> Does
> > > > it play with previously set volume? The default one?
> > >
> > > Default one, to preserve current behavior, yes.
> >
> > This was my idea as well, but I appreciate that the devil is in the
> > details and each driver may have to duplicate some overhead.
> >
> > >
> > > > How to set the default one?
> > >
> > > We do not, we can call pwm_get_duty_cycle() to get the current duty
> > > cycle of the PWM to figure out the default.
> > >
> > > > How
> > > > to figure out what the current volume is if we decide to make
> > > > volume "sticky"?
> > >
> > > The patch stores the current volume configured via sysfs into
> > > beeper->duty_cycle .
> > >
> > > > As far as userspace I expect it is more common to have one program
> > > > (or component of a program) to set volume and then something else
> > > > requests sound, so having one-shot API is of dubious value to me.
> > >
> > > Currently the use case I have for this is a single user facing
> > > application which configures both.
> > >
> > > > I hope we can go with Takashi's proposal downthread, but if not I
> > > > wonder if the sysfs approach is not the simplest one. Do we expect
> > > > more beepers that can control volume besides pwm-beeper?
> > >
> > > It seems to me pulling in dependency on the entire sound subsystem
> > > only to set beeper volume is overkill. I currently don't even have
> > > sound subsystem compiled in.
> >
> > I like Takashi's patch; it seems like a more scalable solution.
> > However, I can appreciate the reluctance to bring in the entire sound
> > subsytem for what is probably a tiny piezoelectric buzzer.
> >
> > It seems like the sysfs solution is the best compromise in the
> > meantime. If more and more users need to shoe-horn these kind of
> > features in the future, we can make more informed decisions as to how t=
o
> extend the API (if at all).
>=20
> That's my impression, too.  The original sysfs usage would be the right f=
it at
> this moment.

I am fine with both using the Sound API and sysfs. I would additionally lik=
e to
specify the pwm values in device-tree like done in pwm-backlight. It really=
 depends
on the hardware which values actually make a difference in volume.

Regards
Manuel
