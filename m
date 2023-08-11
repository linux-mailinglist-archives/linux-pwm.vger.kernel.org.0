Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04EB5778673
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Aug 2023 06:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjHKEUD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Aug 2023 00:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjHKEUC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 11 Aug 2023 00:20:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1683B19AE;
        Thu, 10 Aug 2023 21:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GemP3ncC58l1oTrxs0eA+lP+M33/f1eUBepZWpVLMyjrmO+NqbZqUcUcL3rxxVSi9dz5EcJUFEMajY3djjs0aIVPuL+jUt/0JWB/1W6FzKP9PFc/+Q6rlZ0DYgCTgtqfapqfYNaq37Rj2ZQczfccAdlLka655WJs+MS7dsHZPqGvz/llo6PKZ/2CRo1hwh9voHLs+mCKFyKVTxlhirfcC/vl/D/WBqlqBHqoR/piW4AhH8OKqA1iEfjM7ldmUrp4ztLBkNCb3Qb1lnwMgoabserulamk2saLJ6Yz08CCfQxcAiu4pVED3U+M1YhOIIyib/nnk5owcQHDDPkRWnoFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Il7D4Lz6v6crGErRr19/YfPLf8aM0KBt/WRI79O/Ce8=;
 b=TqCuJ+uKzJd9lQg10+8+4XiDTHRmqyaF6ZRlGzhNFC0y8pmcdi7FXdX8TSBseXU9RyKXIwAoxq88exX4tPMk9h3GfmH90HYwHJZqsvxscnGaksypVikaqZMW2rRsTLu0OsaMkzqAIwQtd3na4O3JV7duwlPaXYZkpLvBW7NWomc9kJGCHZ/eWLIQZ8rG67cI2mz1PWrFw3fXExKAOaPaBB9JU/YmPvCRQXnftTvY+0tqGCcQRjCaafYGBnQ4BFrwt+7CBwFl2xu2nEUPHfWuQdBujD4WveqiDex9IbxF6uYZA7/wAm6yBnoC2EKL5qjSt2RDZZKhLd+XyvHGmZDSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il7D4Lz6v6crGErRr19/YfPLf8aM0KBt/WRI79O/Ce8=;
 b=x9qVsvl/GstcTyJUV4nRU7mKVU0G6cj/kRzLtwLO/P5HAcpUJhwZiU5seW7JH3BGG/CGryJGeqNzel9XqpoDCkayLLeUxalPvU7sVGItIHVQgU5t3B9HgOfXBc7JSWeCmsBLSFlSu773ffRMZzQAB36/FwVuzynlFA21W+ABNwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by BN8PR08MB6227.namprd08.prod.outlook.com
 (2603:10b6:408:7c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 04:19:58 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::88bb:5369:6188:2b05]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::88bb:5369:6188:2b05%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 04:19:58 +0000
Date:   Thu, 10 Aug 2023 23:19:50 -0500
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
Message-ID: <ZNW25qlzh8YbZtu8@nixie71>
References: <63adce9a-df65-b462-9055-0ece5216d680@denx.de>
 <87tttkjmyu.wl-tiwai@suse.de>
 <0cffe366-75af-d8a8-8920-6fb94c321a89@denx.de>
 <87h6pkjh7q.wl-tiwai@suse.de>
 <618add56-3675-4efe-5b20-665c10040e03@denx.de>
 <ZMfgJ3o00nApkXGp@google.com>
 <f4612dc5-a7d4-74ba-2ed8-ea70314625b6@denx.de>
 <ZMh0Sa9s25JHhWw5@nixie71>
 <ZMi0HT/yaTo9uTyi@google.com>
 <d0f284d5-6922-ea3b-3447-c089b0d24587@denx.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0f284d5-6922-ea3b-3447-c089b0d24587@denx.de>
X-ClientProxiedBy: SN7PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:806:126::24) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|BN8PR08MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae38045-c3d8-4ab5-a749-08db9a223904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HBdbzMpzYWddh+BgDRazxDZ1XxLNU+bMaN3JWGZjogzW2hsyWQrsxeKoNN8q2t53izdcqGFaOwHVoe3EBLz+TxofVyfADOdU215EAqjluhfX0fFVOoICslqIsFHaYCTFIHUXxuHZDjFi1jHhbdlZQaeUM/WIqW8eBYMQFIYPh6qEpsqYkO1SRLRYFrYozMMckLH3CgrZHbYpSjiE7JeZPP8elmAX91H2oAIU5RZJVBv53lq8sXlGOxpGdjLCJDuZQBJsmDdzH6cOn9nI0MjKfoJ9wxOOSPsJzDLIu0Yi88IsxKOrAU7BUoaU6qaLNrncVBm76ibH5qqABAcdZPpTmaG4S/ADNjBRa8QHSerqLK+fUXy+gzneMw1MdBo+mWxPaCobZuS5Fwam04s7Cwp6Yj67adcfF9RwGGhoYyVECk8X3JEwhvxPxvRsczn5dMOQSXxLb2+wQv7WY2xop1ADcS4NzktjGBrGbS1E078ZYVeM+RTgk/XIteucVHXvu6usUuLEP5/emGuot6w6T1ivRhXOfHS0NU2g6Im7nxCvbsfKlUrrIIgrq5vBd8EM5Tc/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(366004)(136003)(39830400003)(376002)(186006)(1800799006)(451199021)(53546011)(6916009)(26005)(66946007)(66476007)(6506007)(54906003)(6666004)(478600001)(6486002)(86362001)(66556008)(83380400001)(41300700001)(316002)(33716001)(7416002)(6512007)(4326008)(9686003)(2906002)(8936002)(8676002)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bG4oOi6jovJfR2cLl8gRGCEXLflJQlhN0IqjceKDlTki0TvnhUcUhzdC56n7?=
 =?us-ascii?Q?x+G5t9J/JNARLpD6/hwZR4oC9I+oLpcqFnGwDDfegtfgM5vMbSSm+sgE2CWN?=
 =?us-ascii?Q?rinu6xcr47tAKw0SLoYCOrbXDCaAjC5IXI728uNUjNZIZVpaWe7GHTW3nzfS?=
 =?us-ascii?Q?vZumqtxiRXSP6y0ixyjLm/a7IgHUgcHgXPMgclePYu1KWnHHDfrInDfihERl?=
 =?us-ascii?Q?I8ddxDMDIzc29WNuCIxU5qSuctP9nsGuz+MOZBRAdkSSjCGvkflZueyh4Fy9?=
 =?us-ascii?Q?mz4xZYfY/AOZp+WU6tAcjJBztjsrtylOmh6/T4xnfZETmTtO8bjulSdVg9RQ?=
 =?us-ascii?Q?qUQsUqZco93mdsvqqd3EYDg2xzCJdYedxaXEO/xlNoF9dWzNiXgRYF4MtTAr?=
 =?us-ascii?Q?/9Zuq4vVe7Xa2qVrYpQ+TJbwX65JQtGsc57KKyF2ds91CgXKjw7W3K5hUIHN?=
 =?us-ascii?Q?UfKddydTjpP0o7PBeQQoc5ZBE5U9tA/Xtppu8KZ0aGU/30goBtquKHHfveYl?=
 =?us-ascii?Q?tJa9GFGe0EKY3mbeUSGThvm/4yzWNBNSzVBE+posRZrtGQYdV8q3zrov2wFH?=
 =?us-ascii?Q?bbxsN8YI5PHGx0rne74TipGASse2s5A/w9gtjAKI443crhJZkGkTD8TOLeQ1?=
 =?us-ascii?Q?Nbp1fdoeJOqMKfvCqx6sRVW3RJYchkV8DtOdyl870TIXuGqAI9nAvZc/Yyby?=
 =?us-ascii?Q?dhYDA/nZyguYW+iUIJRX7YMzUAlmogUvJK2VSqwfs8Ri9HMNDWBiuwsK/T9C?=
 =?us-ascii?Q?JZ9wikT1ONF0eaOCUaLQSf/cdvjy+iWMJ5coriq0JkUG+CN49p8qaeP+itdw?=
 =?us-ascii?Q?4z1dBUcaA71exkWE4R6oAz8csaoL84sE4k1lzNW6AsoBhSBxQ8K/sjxyn0bx?=
 =?us-ascii?Q?pHxVURLGcZixV+BqlveaaIGhyseY4XvqXr02Q+WMEH3BsFaD2NUmwWNHF5xp?=
 =?us-ascii?Q?3HW2ECXIWWudcqLsCh71ECL/3u9DFks3pykZVkksTkjGMEq1zqBGSuO1ym/8?=
 =?us-ascii?Q?SomIoEF75YsVlu+6o4aQeBT3fMd3FyK7eZ+TXBb60yc6+LIqlqTniHWjeit0?=
 =?us-ascii?Q?WMlkNFwIVfCQYfQHSKizpqvbJrzEaXitR+lOfl4IgRuBn5EwAdDeta4SDyzj?=
 =?us-ascii?Q?5OxQQxMQ3dKUmvIczC4tMX/PyEGeOGHBVeiO8R7h7S+eMQs0j31U85pVEnOP?=
 =?us-ascii?Q?MHaZls2ZMmei69uiVbQINTOLXG3RKFW9QuvzAvMN/XLmBC17fXivzIHqZS5E?=
 =?us-ascii?Q?RJqHrI2dTJVVRvORNjoI2y0wyAYYlOtqS4eBKmeJWHA2mK6Sp7YvDrgK1AM+?=
 =?us-ascii?Q?5fG2Fddt2Tulf6BC7HF8zT7PItvKve7vbJDoVe3TAguz3vRWrWhIte3G+RpW?=
 =?us-ascii?Q?G8tq+w8pQfXHNEFiHLsz/yLzZ6vGiy9oiAZ8hM1mPF50f0fcF4Fizx1Ynj5t?=
 =?us-ascii?Q?ATTn/aNWAaljShfRaIhOZOIjf3xSg1KOxGQrXNgObicmyl6USUqkdVXqsNUC?=
 =?us-ascii?Q?lhobrCkhBnGnxnUP1gRzHKXasMYP47oM01wsyMuqMvIDsbIN635HJ0HAqPIG?=
 =?us-ascii?Q?B0I+q01B0GzR+9ZyUrny5U5+i3uniJ9fvwX0sd9A?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae38045-c3d8-4ab5-a749-08db9a223904
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 04:19:58.1356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ai4busfnF+aEhYa8IYiHrahfJ6aF9MuUV4eTa7eZq50Sy3F4JBhD2+Z/qavLaQFqVFnskUSV8TLMXFHYPRJE+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR08MB6227
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Marek, Dmitry and Takashi,

On Tue, Aug 01, 2023 at 01:51:50PM +0200, Marek Vasut wrote:
> On 8/1/23 09:28, Dmitry Torokhov wrote:
> > On Mon, Jul 31, 2023 at 09:56:09PM -0500, Jeff LaBundy wrote:
> > > Hi all,
> > > 
> > > On Mon, Jul 31, 2023 at 07:49:50PM +0200, Marek Vasut wrote:
> > > > On 7/31/23 18:24, Dmitry Torokhov wrote:
> > > > > On Mon, Jul 31, 2023 at 04:36:01PM +0200, Marek Vasut wrote:
> > > > > > On 7/31/23 16:20, Takashi Iwai wrote:
> > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > > > > > Uh, I don't need a full sound device to emit beeps, that's not even
> > > > > > > > > > possible with this hardware.
> > > > > > > > > 
> > > > > > > > > Heh, I also don't recommend that route, either :)
> > > > > > > > > (Though, it must be possible to create a sound device with that beep
> > > > > > > > > control in theory)
> > > > > > > > 
> > > > > > > > I mean, I can imagine one could possibly use PCM DMA to cook samples
> > > > > > > > to feed some of the PWM devices so they could possibly be used to
> > > > > > > > generate low quality audio, as a weird limited DAC, but ... that's not
> > > > > > > > really generic, and not what I want.
> > > > > > > 
> > > > > > > Oh I see how the misunderstanding came; I didn't mean the PCM
> > > > > > > implementation like pcsp driver.  The pcsp driver is a real hack and
> > > > > > > it's there just for fun, not for any real practical use.
> > > > > > 
> > > > > > Ah :)
> > > > > > 
> > > > > > > What I meant was rather that you can create a sound device containing
> > > > > > > a mixer volume control that serves exactly like the sysfs or whatever
> > > > > > > other interface, without any PCM stream or other interface.
> > > > > > 
> > > > > > Ahhh, hum, I still feel like this might be a bit overkill here.
> > > > > > 
> > > > > > > > > > I only need to control loudness of the
> > > > > > > > > > beeper that is controlled by PWM output. That's why I am trying to
> > > > > > > > > > extend the pwm-beeper driver, which seems the best fit for such a
> > > > > > > > > > device, it is only missing this one feature (loudness control).
> > > > > > > > > 
> > > > > > > > > So the question is what's expected from user-space POV.  If a more
> > > > > > > > > generic control of beep volume is required, e.g. for desktop-like
> > > > > > > > > usages, an implementation of sound driver wouldn't be too bad.
> > > > > > > > > OTOH, for other specific use-cases, it doesn't matter much in which
> > > > > > > > > interface it's implemented, and sysfs could be an easy choice.
> > > > > > > > 
> > > > > > > > The whole discussion above has been exactly about this. Basically the
> > > > > > > > thing is, we can either have:
> > > > > > > > - SND_TONE (via some /dev/input/eventX) + sysfs volume control
> > > > > > > >      -> This is simple, but sounds racy between input and sysfs accesses
> > > > > > > 
> > > > > > > Hmm, how can it be racy if you do proper locking?
> > > > > > 
> > > > > > I can imagine two applications can each grab one of the controls and that
> > > > > > makes the interface a bit not nice. That would require extra synchronization
> > > > > > in userspace and so on.
> > > > > > 
> > > > > > > > - SND_TONE + SND_TONE_SET_VOLUME
> > > > > > > >      -> User needs to do two ioctls, hum
> > > > > > > > - some new SND_TONE_WITH_VOLUME
> > > > > > > >      -> Probably the best option, user sets both tone frequency and volume
> > > > > > > >         in one go, and it also only extends the IOCTL interface, so older
> > > > > > > >         userspace won't have issues
> > > > > > > 
> > > > > > > Those are "extensions" I have mentioned, and I'm not a big fan for
> > > > > > > that, honestly speaking.
> > > > > > > 
> > > > > > > The fact that the beep *output* stuff is provided by the *input*
> > > > > > > device is already confusing
> > > > > > 
> > > > > > I agree, this confused me as well.
> > > > > 
> > > > > This comes from the times when keyboards themselves were capable of
> > > > > emitting bells (SUN, DEC, etc). In hindsight it was not the best way of
> > > > > structuring things, same with the keyboard LEDs (that are now plugged
> > > > > into the LED subsystem, but still allow be driven through input).
> > > > > 
> > > > > And in the same vein I wonder if we should bite the bullet and pay with
> > > > > a bit of complexity but move sound-related things to sound subsystem.
> > > > 
> > > > I am not sure that's the right approach here, since the device cannot do PCM
> > > > playback, just bleeps.
> > > > 
> > > > > > > (it was so just because of historical
> > > > > > > reason), and yet you start implementing more full-featured mixer
> > > > > > > control.  I'd rather keep fingers away.
> > > > > > > 
> > > > > > > Again, if user-space requires the compatible behavior like the
> > > > > > > existing desktop usages
> > > > > > 
> > > > > > It does not. These pwm-beeper devices keep showing up in various embedded
> > > > > > devices these days.
> > > > > > 
> > > > > > > , it can be implemented in a similar way like
> > > > > > > the existing ones; i.e. provide a mixer control with a proper sound
> > > > > > > device.  The sound device doesn't need to provide a PCM interface but
> > > > > > > just with a mixer interface.
> > > > > > > 
> > > > > > > Or, if the purpose of your target device is a special usage, you don't
> > > > > > > need to consider too much about the existing interface, and try to
> > > > > > > keep the change as minimal as possible without too intrusive API
> > > > > > > changes.
> > > > > > 
> > > > > > My use case is almost perfectly matched by the current input pwm-beeper
> > > > > > driver, the only missing bit is the ability to control the loudness at
> > > > > > runtime. I think adding the SND_TONE_WITH_VOLUME parameter would cover it,
> > > > > > with least intrusive API changes.
> > > > > > 
> > > > > > The SND_TONE already supports configuring tone frequency in Hz as its
> > > > > > parameter. Since anything above 64 kHz is certainly not hearable by humans,
> > > > > > I would say the SND_TONE_WITH_VOLUME could use 16 LSbits for frequency (so
> > > > > > up to 65535 Hz , 0 is OFF), and 16 MSbits for volume .
> > > > > > 
> > > > > > I'm hesitant to overcomplicate something which can currently be controlled
> > > > > > via single ioctl by pulling in sound subsystem into the picture.
> > > > > 
> > > > > Can you tell a bit more about your use case? What needs to control the
> > > > > volume of beeps? Is this the only source of sounds on the system?
> > > > 
> > > > Custom user space application. The entire userspace is custom built in this
> > > > case.
> > > > 
> > > > In this case, it is a single-use device (think e.g. the kind of thermometer
> > > > you stick in your ear when you're ill, to find out how warm you are).
> > > > 
> > > > The beeper there is used to do just that, bleep (with different frequencies
> > > > to indicate different stuff), and that works. What I need in addition to
> > > > that is control the volume of the bleeps from the application, so it isn't
> > > > too noisy. And that needs to be user-controllable at runtime, so not
> > > > something that goes in DT.
> > > > 
> > > > Right now there is just the bleeper , yes.
> > > 
> > > It sounds like we essentially need an option within pcsp to drive PWM
> > > instead of PCM, but input already has pwm-beeper; it seems harmless to
> > > gently extend the latter for this use-case as opposed to reworking the
> > > former.
> > > 
> > > I agree that we should not invest too heavily in a legacy ABI, however
> > > something like SND_BELL_VOL seems like a low-cost addition that doesn't
> > > work against extending pcsp in the future. In fact, input already has
> > > precedent for this exact same thing by way of FF rumble effects, which
> > > are often PWM-based themselves.
> > > 
> > > If SND_BELL_VOL or similar is not acceptable, then the original sysfs
> > > approach seems like the next-best compromise. My only issue with it was
> > > that I felt the range was not abstracted enough.
> > 
> > If we want to extend the API we will need to define exactly how it will
> > all work. I.e. what happens if userspace mixes the old SND_TONE and
> > SND_BELL with the new SND_BELL_VOL or whatever. Does it play with
> > previously set volume? The default one?
> 
> Default one, to preserve current behavior, yes.

This was my idea as well, but I appreciate that the devil is in the details
and each driver may have to duplicate some overhead.

> 
> > How to set the default one?
> 
> We do not, we can call pwm_get_duty_cycle() to get the current duty cycle of
> the PWM to figure out the default.
> 
> > How
> > to figure out what the current volume is if we decide to make volume
> > "sticky"?
> 
> The patch stores the current volume configured via sysfs into
> beeper->duty_cycle .
> 
> > As far as userspace I expect it is more common to have one program (or
> > component of a program) to set volume and then something else requests
> > sound, so having one-shot API is of dubious value to me.
> 
> Currently the use case I have for this is a single user facing application
> which configures both.
> 
> > I hope we can go with Takashi's proposal downthread, but if not I wonder
> > if the sysfs approach is not the simplest one. Do we expect more beepers
> > that can control volume besides pwm-beeper?
> 
> It seems to me pulling in dependency on the entire sound subsystem only to
> set beeper volume is overkill. I currently don't even have sound subsystem
> compiled in.

I like Takashi's patch; it seems like a more scalable solution. However, I
can appreciate the reluctance to bring in the entire sound subsytem for what
is probably a tiny piezoelectric buzzer.

It seems like the sysfs solution is the best compromise in the meantime. If
more and more users need to shoe-horn these kind of features in the future,
we can make more informed decisions as to how to extend the API (if at all).

Kind regards,
Jeff LaBundy
