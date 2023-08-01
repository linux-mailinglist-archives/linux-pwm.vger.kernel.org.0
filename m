Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C659C76A737
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Aug 2023 04:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjHAC4X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Jul 2023 22:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjHAC4W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 Jul 2023 22:56:22 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5D9114;
        Mon, 31 Jul 2023 19:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PI/+CdGSN9nnLMlV2eHpaJKgqEoFv5la2eWDoL2th55bb3QyxBVp+ua5yyanBqkxMdnfK0RZSDTgQYv/lwC9rZ5uEW2Za/HUMVMgjirw1PA9JmYUy+cAQ/VBwSheywtUpps+sno4tMgpwWIeKM/BMA6y45SqJWj5D3QEBVazp8c+CiNZMW6Xz80mUe3fmgRuaSfq2V/Bd4D1M0Q66EJU3isXMzIQtDPH/l/XnbI5e6tiu+rnhcOuunk8RSss7lHrHnaYWkA0SboxKWe+6jD/dtgR5FXqkZ9Q77jDxA52QFpiUMKVVJlajlF2dOZcMCYbkRrkFPh041CcoHLylskP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51GCW5u5YFq8/KyDC2W2dNIqKfP0RY2ozd49vAMtafw=;
 b=ZFV6ORm8hMIpeOsuZpvxCpSQSVs6c0G0bHXjag223vM452GgQMHltKlPgQIuDpdqI9TUs47xE7ewR4LdFstZuxfFCWXKaNtM8h6wpLUHYRaKA4IwLUVdtRdck083XdK1/WSZz+M0vD6g3f8VXA9hYiytvpm910rRr5o6Rf1suEFM3h1bG612rDYfZt4GBH4/jwLUiedu6FhJo8oIyx2XKLPiorNaj0VDzexiRWyggmJl1gB3mQIQjm0FjoTxjXMM5dE1b+IN1sgWORD9wnYOMIxjx+yVEsfC4PVzEn3DsBV6l0roV7HHTyG2tT4/oY9owE5/Fm/ssJSNs3LwHvCSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51GCW5u5YFq8/KyDC2W2dNIqKfP0RY2ozd49vAMtafw=;
 b=n4GvIkTAI5w6YIYunequFHiKaFWghxf7FeDTtZiX9A5TngiPsme3aDN9Xcj13BKjJtjD9QhIzltgJB3oxR8XnFIggJPADgafUQTpLOA1B27TdWWYeIYYNhmLjlC5et5gNb2UOzBxQewJwKkTVxCVLdf7f+vcyrWgogSNd9zdLuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by CYXPR08MB9393.namprd08.prod.outlook.com
 (2603:10b6:930:e1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 02:56:18 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::3330:a9d7:a566:68b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::3330:a9d7:a566:68b2%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 02:56:17 +0000
Date:   Mon, 31 Jul 2023 21:56:09 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Marek Vasut <marex@denx.de>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Manuel Traut <manuel.traut@mt.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] Input: pwm-beeper - Support volume setting via sysfs
Message-ID: <ZMh0Sa9s25JHhWw5@nixie71>
References: <06379f26-ab24-85f9-783f-0c49d4291b23@denx.de>
 <ZMdIZiC453onyeHh@google.com>
 <873514d2ju.wl-tiwai@suse.de>
 <63adce9a-df65-b462-9055-0ece5216d680@denx.de>
 <87tttkjmyu.wl-tiwai@suse.de>
 <0cffe366-75af-d8a8-8920-6fb94c321a89@denx.de>
 <87h6pkjh7q.wl-tiwai@suse.de>
 <618add56-3675-4efe-5b20-665c10040e03@denx.de>
 <ZMfgJ3o00nApkXGp@google.com>
 <f4612dc5-a7d4-74ba-2ed8-ea70314625b6@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4612dc5-a7d4-74ba-2ed8-ea70314625b6@denx.de>
X-ClientProxiedBy: SA0PR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:806:d2::30) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|CYXPR08MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f24398-eb88-4e7d-39db-08db923adfa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpD+UaQJ8Xr9UdS0VGxGAlYPbnHX39/ZONo0WoxcPLVZZTOISRRfzt9CbSDGjCLQpipJ148jRuKuBmFZ6M93eunsuY/0z5/RMKA0Ju1EdaidYfLd0CM67fenCaH3XVjIPHa0L+yS95rNsPFkDNOImFR0G8iMqDbjiG95DGZZRJ74Zj9dyM4f3427Au2xo+HajYgZmrkOeLpQSpVNPtVW31sHyhhhHDuqEmJyHBtkGURaO+zWumX28xMl+jSZSN4gRGiTTYb2nGJnbyAtV7mJ09FUArmMvraC71NLocaA/89A70eZXX2rLl6LaspN3h1sSeus50qSLcJIO0Aey4WcOn7FqsIM1rsdq+sozuUIXZ+HSNG+ekzppsAkt//oAOdNoj90LSKV26539qB317H8qw0ACrewD2YAptd3OLN9KUY0tLxHKx5vi26UJ3ZPfZsZBYzCY7PvfJFK0ZJM8l/h1rkQ1MmuPCLx8P8kRW6gf+iMy3beObnS6MFn/qMymGAr0dxWPLb/yEhfuhPz6Upv+Y1fqk4fFXFb509nRj2I0tDtPXMNUZ7DYr81DROIIfNW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(376002)(136003)(39830400003)(396003)(451199021)(9686003)(6512007)(6486002)(53546011)(6506007)(26005)(83380400001)(186003)(66946007)(66556008)(7416002)(54906003)(33716001)(41300700001)(38100700002)(86362001)(66476007)(316002)(5660300002)(6916009)(4326008)(8676002)(8936002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0emcQc4V5mibrPwVE1RUHHCSYu6LC3g3PdKCrB9l7Dk1WdcSVWeKdBEkmFlB?=
 =?us-ascii?Q?y6R/pBKoVVlAuf0jjgwcvX9P/q+Ozp4qpfdj1AZceOH63z54LkNOlmurugqX?=
 =?us-ascii?Q?hK2KsiqPtpTsCfdaH55kqsLjDgjyBXkLT3zo2OTwEiFQSFpnndmXvea6DYAn?=
 =?us-ascii?Q?zjETK3c3Fu1RyQQ1gyS/Q+KNUkYQU7sDh5PxRffl3GhHALAmLpqH+G9fo9na?=
 =?us-ascii?Q?8KV8Y7MPQ6fA6KSJgkUTznVCGIrT1aaAXiCz+8P5rPs/yDxefsdoMdj0TZ8t?=
 =?us-ascii?Q?0KzQLo+tZ6mVZ+j2iLrcM5NyTnqtJksY1zbi9IPFE2lEAz+9ZO07c8y4fROf?=
 =?us-ascii?Q?WzhGrPwra8X+JHnxMP586KEpF7pBYFqrGxztOIG1Ozfe+OHF9pwZqKyCzvMt?=
 =?us-ascii?Q?aviGjm1Iq3hserZl3Su8KaJ2tkJ63f8EYTyQn9i3m0m2HkG567v6aZ7X3KQ3?=
 =?us-ascii?Q?tyakxqzAbxuZNkED0E+LtBH0GIHlrDZCCIOqSZFanJvRz7AZghDxPqG0MRsk?=
 =?us-ascii?Q?jCTNl8gpD85AV8/qb8CJoH8dUsYvqst6GVY+dR2tJIWdICNDnJB9czaErbk1?=
 =?us-ascii?Q?jRa8N40HTYQk2VBRVTddv92f8DQEWGlM9cdnOL21k0sAnJFcCjptZyrB4ZSX?=
 =?us-ascii?Q?t4RUSF+HylQnK9u2QQH8x7L31+4xq9AGLk/eFvzHI3IU8myfEtmp7w922kEN?=
 =?us-ascii?Q?Q4OKq6ZmZU8GtfpiNf72u/uN2FMV+VhOQ5956fgriEAQ4KzB7rWwp5ZRKGjq?=
 =?us-ascii?Q?cItqt8kdLx+xMLE7D4EuqDf1jEArV/47sJ3z52oHy+fxIn/vAwnSVKFcr0C1?=
 =?us-ascii?Q?qWvigcK8k+qkoIhT9U9RKRSjGnB/pBjw+qBfw74N2uHi6yOPL+O0oA6Scy2u?=
 =?us-ascii?Q?QTnKBGbP40kk8d1H4As66ijSipOWCBpBeK9NdO2IuCEt2O2Atc5Rm9J+ZJp0?=
 =?us-ascii?Q?kSFxwLjzdRCve6HSYIG2TVlWTRqpLhXT+7lCOSYAXP5V4uGxOVqF6kEKmLvb?=
 =?us-ascii?Q?V2PYjEUC0COtOR8Kq0m2SIAECVXPUQ51RqqE2BOrHskDlaBMFe6i8wiVOJrj?=
 =?us-ascii?Q?lpG99CaVhR9mD2LGCjyKvOIt3dOMe9PJtSL4OV+eE8fk41g08TTtkLUGLr4y?=
 =?us-ascii?Q?pNGExZkD+9fV/m65YXfIwWRos6Masq+qyDGWZ/b+dzGa2TqrLq4eSFh7HNag?=
 =?us-ascii?Q?55Kw95aLLCN2/6locKp9AWMVAx/Fnj6P8Xn5I1uZWhU9AkHYc71dikd4eOn9?=
 =?us-ascii?Q?Ic594YIpoEMuvQBAWAy4jfPIobDSdSZbMdIyJP0wWzLLVTUr40yArE0KIzuU?=
 =?us-ascii?Q?wJWVwML+EyNGptsa8u6klpwhzQKnXq3Jr2hXBFewWY+yD7MFysh0EmeLFHp5?=
 =?us-ascii?Q?dqzppEV5neFdH8BnxVaR2+D9M9ibthYxuiuk/8HwFJBMNrjJhiAPTwCz5DkF?=
 =?us-ascii?Q?3hsdUXTME4tS1hFvkWVvZOIgsJTvWn8CPrbAHiD5KsjNAb8Nc5/0BsN1bW8v?=
 =?us-ascii?Q?+Uv/9nPvnqNwedlnwhaUMG7+iLLG/lVkgm3f8r0RINIJ3MUCKfRW6gNfUY0f?=
 =?us-ascii?Q?Gi5FhtgJNLHABHOWf0ub990DZp+abaxpd4b61qBP?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f24398-eb88-4e7d-39db-08db923adfa2
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 02:56:16.6336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fp0LPs7GV4kdmM8RU8kc77jlOUFlY31gd69Zi1/AWI5d+BLsiMeT6PJTXON0akUKlCsRjLTMJ72NTjnbIpOwnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR08MB9393
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi all,

On Mon, Jul 31, 2023 at 07:49:50PM +0200, Marek Vasut wrote:
> On 7/31/23 18:24, Dmitry Torokhov wrote:
> > On Mon, Jul 31, 2023 at 04:36:01PM +0200, Marek Vasut wrote:
> > > On 7/31/23 16:20, Takashi Iwai wrote:
> > > 
> > > [...]
> > > 
> > > > > > > Uh, I don't need a full sound device to emit beeps, that's not even
> > > > > > > possible with this hardware.
> > > > > > 
> > > > > > Heh, I also don't recommend that route, either :)
> > > > > > (Though, it must be possible to create a sound device with that beep
> > > > > > control in theory)
> > > > > 
> > > > > I mean, I can imagine one could possibly use PCM DMA to cook samples
> > > > > to feed some of the PWM devices so they could possibly be used to
> > > > > generate low quality audio, as a weird limited DAC, but ... that's not
> > > > > really generic, and not what I want.
> > > > 
> > > > Oh I see how the misunderstanding came; I didn't mean the PCM
> > > > implementation like pcsp driver.  The pcsp driver is a real hack and
> > > > it's there just for fun, not for any real practical use.
> > > 
> > > Ah :)
> > > 
> > > > What I meant was rather that you can create a sound device containing
> > > > a mixer volume control that serves exactly like the sysfs or whatever
> > > > other interface, without any PCM stream or other interface.
> > > 
> > > Ahhh, hum, I still feel like this might be a bit overkill here.
> > > 
> > > > > > > I only need to control loudness of the
> > > > > > > beeper that is controlled by PWM output. That's why I am trying to
> > > > > > > extend the pwm-beeper driver, which seems the best fit for such a
> > > > > > > device, it is only missing this one feature (loudness control).
> > > > > > 
> > > > > > So the question is what's expected from user-space POV.  If a more
> > > > > > generic control of beep volume is required, e.g. for desktop-like
> > > > > > usages, an implementation of sound driver wouldn't be too bad.
> > > > > > OTOH, for other specific use-cases, it doesn't matter much in which
> > > > > > interface it's implemented, and sysfs could be an easy choice.
> > > > > 
> > > > > The whole discussion above has been exactly about this. Basically the
> > > > > thing is, we can either have:
> > > > > - SND_TONE (via some /dev/input/eventX) + sysfs volume control
> > > > >     -> This is simple, but sounds racy between input and sysfs accesses
> > > > 
> > > > Hmm, how can it be racy if you do proper locking?
> > > 
> > > I can imagine two applications can each grab one of the controls and that
> > > makes the interface a bit not nice. That would require extra synchronization
> > > in userspace and so on.
> > > 
> > > > > - SND_TONE + SND_TONE_SET_VOLUME
> > > > >     -> User needs to do two ioctls, hum
> > > > > - some new SND_TONE_WITH_VOLUME
> > > > >     -> Probably the best option, user sets both tone frequency and volume
> > > > >        in one go, and it also only extends the IOCTL interface, so older
> > > > >        userspace won't have issues
> > > > 
> > > > Those are "extensions" I have mentioned, and I'm not a big fan for
> > > > that, honestly speaking.
> > > > 
> > > > The fact that the beep *output* stuff is provided by the *input*
> > > > device is already confusing
> > > 
> > > I agree, this confused me as well.
> > 
> > This comes from the times when keyboards themselves were capable of
> > emitting bells (SUN, DEC, etc). In hindsight it was not the best way of
> > structuring things, same with the keyboard LEDs (that are now plugged
> > into the LED subsystem, but still allow be driven through input).
> > 
> > And in the same vein I wonder if we should bite the bullet and pay with
> > a bit of complexity but move sound-related things to sound subsystem.
> 
> I am not sure that's the right approach here, since the device cannot do PCM
> playback, just bleeps.
> 
> > > > (it was so just because of historical
> > > > reason), and yet you start implementing more full-featured mixer
> > > > control.  I'd rather keep fingers away.
> > > > 
> > > > Again, if user-space requires the compatible behavior like the
> > > > existing desktop usages
> > > 
> > > It does not. These pwm-beeper devices keep showing up in various embedded
> > > devices these days.
> > > 
> > > > , it can be implemented in a similar way like
> > > > the existing ones; i.e. provide a mixer control with a proper sound
> > > > device.  The sound device doesn't need to provide a PCM interface but
> > > > just with a mixer interface.
> > > > 
> > > > Or, if the purpose of your target device is a special usage, you don't
> > > > need to consider too much about the existing interface, and try to
> > > > keep the change as minimal as possible without too intrusive API
> > > > changes.
> > > 
> > > My use case is almost perfectly matched by the current input pwm-beeper
> > > driver, the only missing bit is the ability to control the loudness at
> > > runtime. I think adding the SND_TONE_WITH_VOLUME parameter would cover it,
> > > with least intrusive API changes.
> > > 
> > > The SND_TONE already supports configuring tone frequency in Hz as its
> > > parameter. Since anything above 64 kHz is certainly not hearable by humans,
> > > I would say the SND_TONE_WITH_VOLUME could use 16 LSbits for frequency (so
> > > up to 65535 Hz , 0 is OFF), and 16 MSbits for volume .
> > > 
> > > I'm hesitant to overcomplicate something which can currently be controlled
> > > via single ioctl by pulling in sound subsystem into the picture.
> > 
> > Can you tell a bit more about your use case? What needs to control the
> > volume of beeps? Is this the only source of sounds on the system?
> 
> Custom user space application. The entire userspace is custom built in this
> case.
> 
> In this case, it is a single-use device (think e.g. the kind of thermometer
> you stick in your ear when you're ill, to find out how warm you are).
> 
> The beeper there is used to do just that, bleep (with different frequencies
> to indicate different stuff), and that works. What I need in addition to
> that is control the volume of the bleeps from the application, so it isn't
> too noisy. And that needs to be user-controllable at runtime, so not
> something that goes in DT.
> 
> Right now there is just the bleeper , yes.

It sounds like we essentially need an option within pcsp to drive PWM
instead of PCM, but input already has pwm-beeper; it seems harmless to
gently extend the latter for this use-case as opposed to reworking the
former.

I agree that we should not invest too heavily in a legacy ABI, however
something like SND_BELL_VOL seems like a low-cost addition that doesn't
work against extending pcsp in the future. In fact, input already has
precedent for this exact same thing by way of FF rumble effects, which
are often PWM-based themselves.

If SND_BELL_VOL or similar is not acceptable, then the original sysfs
approach seems like the next-best compromise. My only issue with it was
that I felt the range was not abstracted enough.

A fourth option would be to use leds-pwm with a oneshot trigger; this
would render the exact same function. This is obviously a hack, however
downstream vendor kernels implement this kind of blasphemy all the time.

Kind regards,
Jeff LaBundy
