Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 221E2182C23
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 10:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCLJOO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 12 Mar 2020 05:14:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:23334 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbgCLJOO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 05:14:14 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-9-6SWbZ0TDPPuNfXXMJ3Jmdw-1;
 Thu, 12 Mar 2020 09:14:10 +0000
X-MC-Unique: 6SWbZ0TDPPuNfXXMJ3Jmdw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 12 Mar 2020 09:14:09 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 12 Mar 2020 09:14:09 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guru Das Srinagesh' <gurus@codeaurora.org>
CC:     "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v8 01/12] clk: pwm: Use 64-bit division function
Thread-Topic: [PATCH v8 01/12] clk: pwm: Use 64-bit division function
Thread-Index: AQHV90YvPG+mI4RpM0Wy3POJxK2r86hDnJdAgACbbwCAAHWSkA==
Date:   Thu, 12 Mar 2020 09:14:09 +0000
Message-ID: <fea86a43b28f4493abe0826654369513@AcuMS.aculab.com>
References: <cover.1583889178.git.gurus@codeaurora.org>
 <338966686a673c241905716c90049993e7bb7d6a.1583889178.git.gurus@codeaurora.org>
 <7506bc2972324fd286dac6327ec73a3a@AcuMS.aculab.com>
 <20200312020938.GA14827@codeaurora.org>
In-Reply-To: <20200312020938.GA14827@codeaurora.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Guru Das Srinagesh
> Sent: 12 March 2020 02:10
> On Wed, Mar 11, 2020 at 04:58:24PM +0000, David Laight wrote:
> > From: Guru Das Srinagesh
> > > Sent: 11 March 2020 01:41
> > >
> > > Since the PWM framework is switching struct pwm_args.period's datatype
> > > to u64, prepare for this transition by using div64_u64 to handle a
> > > 64-bit divisor.
> > >
...
> > > --- a/drivers/clk/clk-pwm.c
> > > +++ b/drivers/clk/clk-pwm.c
> > > @@ -89,7 +89,7 @@ static int clk_pwm_probe(struct platform_device *pdev)
> > >  	}
> > >
> > >  	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
> > > -		clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
> > > +		clk_pwm->fixed_rate = div64_u64(NSEC_PER_SEC, pargs.period);
> >
> > That cannot be needed, a 32 bit division is fine.
> 
> Could you please explain why? I think the use of this function is
> warranted in order to handle the division properly with a 64-bit
> divisor.
...
> > I'd assign pargs.period to an 'unsigned int' variable
> > prior to the division (I hate casts - been bitten by them in the past.).
> 
> Wouldn't this truncate the 64-bit value? The intention behind this patch
> is to allow the processing of 64-bit values in full.

You are dividing a 32bit constant by a value.
If pargs.period is greater than 2^32 the result is zero.
I think you divide by 'fixed_rate' a bit later on - better not be zero.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

