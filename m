Return-Path: <linux-pwm+bounces-9084-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OGpDD9eEGqDWgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9084-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 15:46:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D21895B56FB
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 15:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26DA4303C4DB
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2026 13:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609E3FF8BA;
	Fri, 22 May 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipeDJUhq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0753FA5DA;
	Fri, 22 May 2026 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457124; cv=none; b=Yh3S3KoS6sEbzjiJts/T6ZG1j4Uw6bz17aK04wTMvcMi11ZDBCZesghrpciJyWfKxFfvTF3t8YvHwrKgq7cFN8SJzUQjL/DvKcssTtyZM9TLkPoiI9H3l7yk0N116E5eY6NGRe+xfn+sXZo8vwsVFh7bL/2RRrs7V2AEkuUSMiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457124; c=relaxed/simple;
	bh=VTIq37iy9DUOokRQnz3PLEP+l6B+THmSP5B+u2rjDgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rn7aI0UqVsymVvuFR4Nj+ErXbsTsQ3jLz0tucwDjCiZqW7z53qNUma3QSgHtBwUk1sJYXTuRqGwQzeRz2OCpx0p6Axb3tAx27yP5ZkSHO0TKPdN75sjVPx1LFCWcZG70KX67uSqE9/vw7IbyL7T4/6l0cS+HvPwMXqDvfBJy62Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipeDJUhq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCAB1F000E9;
	Fri, 22 May 2026 13:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779457120;
	bh=2sEt+pfVTqi62XRpqK9+If4oDJrLR/RRwahq5GJ1eB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ipeDJUhqXzLNXV3/kjrZjDcIBrdBMJrwhEHGT2yPJuyIrzQGmgeY0+FCUspfdVakj
	 tKtadiizz3RYaUAl/qxmetY8aUqVwRKhcKNnc1UI81X9WPjCQRGX6uGy833WAmoo/v
	 pNs2OGjecBi4w8XzEExuumnilUumrLyq9oDY2pxIVNPb3cpXP7UZ/fukc76kkcUo0P
	 mg2BrZCa+bsYI8JnwmJqXAVkVk/Fh+gS7rXE2XYI9rK2/aMGjNny/SRXRLUZoUk2zU
	 052gpvCVoi3e4HmokXZA8wMezUzWEmpRXkWs489liV+CIW+dh1/Jh3ozRFoy42sjMZ
	 GV2/wMk0o5l7w==
Date: Fri, 22 May 2026 14:38:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v12 5/6] iio: adc: ad4691: add oversampling support
Message-ID: <20260522143827.013a985c@jic23-huawei>
In-Reply-To: <LV9PR03MB8414E63DA5C2C22A46E98215F70F2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260519-ad4692-multichannel-sar-adc-driver-v12-0-5b335162aa51@analog.com>
	<20260519-ad4692-multichannel-sar-adc-driver-v12-5-5b335162aa51@analog.com>
	<LV9PR03MB8414CA3DB26235605C9323E5F70E2@LV9PR03MB8414.namprd03.prod.outlook.com>
	<20260522121628.21bf03f9@jic23-huawei>
	<LV9PR03MB8414E63DA5C2C22A46E98215F70F2@LV9PR03MB8414.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9084-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D21895B56FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 11:38:55 +0000
"Sabau, Radu bogdan" <Radu.Sabau@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Friday, May 22, 2026 2:16 PM  
> 
> ...
> 
> > > >
> > > > +	iio_for_each_active_channel(indio_dev, bit) {
> > > > +		ret = regmap_write(st->regmap,
> > > > AD4691_ACC_DEPTH_IN(bit), st->osr[bit]);  
> > >
> > > Unfortunately enough, I think a v13 will come, too...
> > >
> > > Had a look again on what Sashiko had to say, and seeing the sampling  
> > frequency  
> > > shared_by_all comment again made me have a deeper look see how the  
> > code could  
> > > be commented so he wouldn't complain about this anymore, and...
> > >
> > > Perhaps he is a bit right after all. I found a section stating that in standard
> > > sequencer mode (which the driver uses right now), all the channels actually  
> > use  
> > > the ACC_DEPTH_IN0 for osr, and so changing ACC_DEPTH_INn for other  
> > channels  
> > > doesn't really do much. And so I tested this selecting both voltage0 and  
> > voltage1  
> > > for sampling with osr4 for voltage0 and osr1 for voltage1 and with a 100kHz  
> > osc freq  
> > > indeed DR fell after approximately 80us which points out both channels were  
> > actually  
> > > using OSR of 4. Perhaps the OSR should be shared by all and therefore the
> > > sampling frequency would also be shared by all, right?  
> > 
> > I kind of lost track on the modes. What are the chances we later move to or
> > add
> > support for a mode where the different OSRs do matter?  If that's a possibility
> > we should avoid ABI change by allowing for it from the start.
> > 
> > Then if we are in this mode, they'll have separate controls but change any,
> > changes
> > them all, if we are in a different mode that connection breaks.
> > If that's the case, just throw in a comment saying something to the effect this
> > may change.
> > 
> > It's not wrong ABI to do this, it's just less intuitive for users which is why
> > we prefer the shared_by stuff where there isn't a disadvantage.  That is at
> > most
> > a hint to what actually happens.   A simple example is where different
> > channels have one OSR field but they aren't the same - i.e. channel 1 is twice
> > the OSR of channel 2.  Hence we can't share the attribute but any change
> > effects
> > both.
> >   
> 
> Hi Jonathan,
> 
> I don't think a mode where different OSR will matter will be added in the future. Better
> yet, this advanced sequencer functionality is not really mode dependent and is actually
> something that allows you to manually rearrange channels and samples in the
> sequence, and unless this functionality is active (it is not by default nor is it used by
> the driver, since we use the standard sequencer).
> 
> Personally, I don't see any reason to have this advanced sequencer stuff implemented
> since DR is only falling at the end of the sequence no matter if it is standard config or not,
> the only "disadvantage" to say so is that the standard sequencer uses the same OSR field
> for all channels. But that advanced sequencer stuff would only complicate the buffer
> enable/disable functions even more, which I don't think it's worth the effort.
> 
> So, with this in mind. Letting the driver use standard sequencer would ultimately mean
> that the osr would be the same for all the channels, and then effective rate the same for
> all channels, which I suggest having it like that from initial driver patch to the end, so no
> ABI change mid-patch series. This change will simplify the driver.

Ok.  Thanks for the analysis.  It may well be that those fancy sequencer things are
only really useful for very specific use cases we won't see in Linux.

So I'm fine with following the simple path!

Jonathan

> 
> Radu


