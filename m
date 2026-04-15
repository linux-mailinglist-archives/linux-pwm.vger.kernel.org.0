Return-Path: <linux-pwm+bounces-8581-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FBKAyhL32mFRQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8581-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 10:24:08 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC03401E49
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 10:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D91E53028EE1
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Apr 2026 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1362C3CD8A5;
	Wed, 15 Apr 2026 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0k3KIXT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577053CA4AB
	for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2026 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241214; cv=none; b=AoD/OZftLdPlc6OSFzHR97/3pWohujpwJptKqQ+fNrNul0GIBjkbI9U8dCpSSHhDE8S16OclnK8ECh2lUDG7jWSI0AOZWg1cv01kKpYryBcwdcpdjziGo7cRq0GyL+MR8mvEu4cr84qL+wk/zBceG71K4/6quz1D4bOYu+K+dtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241214; c=relaxed/simple;
	bh=AS429itr7wbpGuNOk5jL7MlDnLt1qmHnn3vRkHB1nVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ybuyqf2Qz3ABmUJFOalUye29Lb/bSM+haYiAJ9by/DAj1GLYgTcGJuYekrRKFWQI6HTH3iWXNoauIT2YT1lYUxObOZlT9Zgth18wV8iXCKE36qlvTUWAq7bCWG7a+jn3fIN1+Mdr1rNKXN7G7lFSMmiiehGBNrTKGR7L27ZmLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0k3KIXT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso60816545e9.3
        for <linux-pwm@vger.kernel.org>; Wed, 15 Apr 2026 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241211; x=1776846011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0otFmE3OfgX1ocRffAsBD3VgKhSHJKmOocoLMY68w2Q=;
        b=O0k3KIXTrRRTXq7ITdfsgz4CqfxhnnsMH1eB/RPf8ZrOiN+jGV7dxT1ik7p8SNFD4O
         jI4fSaTYA40PH2meeWkBVio+RGdNX7bS+9NrufjDQektPsXipRcOjrxVkTI/J14sF9ht
         d77eO62p8G4jsUCwh4bijIM1BiLwlzJL1GQg4D0UumwndDvsJ/ToV/MMIzQu3U94vpzW
         d+h8ES2B1K9GtcErvIv2vEtf4/CKmgUtbstgEbZNpyD6/mIEhXR3MbOkWvMXBVrzr645
         6PG1yiI5JiN3JouibmvfbLp9TGVvQyIoh/jCNDHZu4Z1q6tTGGVK4XR2rFetxvd9dSce
         hm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241211; x=1776846011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0otFmE3OfgX1ocRffAsBD3VgKhSHJKmOocoLMY68w2Q=;
        b=bQoUCJmtT4LzcnW3w2mv+VJSngWhLn3lNIp0nz+AkHJnAMY+UFzcgmjzprIxLrliYx
         oUou4vH8GJFN8ai7NAnMtkGshVbPMb22wDJZhbVYRs5sJXbGQ2TAT+fXKGDb8O4Dmqhr
         9h1kkI+nWI2P3va9f+INmR4Oh0wwg2WWGaf6f5sapBqZCbhsX6zk6WQHj+tXXsLToz+o
         tX7AiWYcZ4TRtyarv3rRHq4DbTwhGDBT5E0Qn0OuqE0WA9eooArTITDT79hm2jY080hK
         /KyclbC4qN9q2UIRwL08Daz9dKPfgpWGhM93mdvIPPOScjoE9ZQWC3BJ0zFqO2p/v18Z
         pJuw==
X-Forwarded-Encrypted: i=1; AFNElJ+D2gU0SccfYE2lIBmT45/7rGhX5N4Z3p+8BXlMEqk22JYsEjZKQgqyslR9RG6db2R2xjF9oSyvdWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGr6YziDWjl4WyOyVSsdmwKi4NbeWepypimkyXdy02/rskGTvF
	tPC79GSgtp76Vn71WCANgj5g0oXqC4qP+bIFinb2QrC+t9wG+Noas9C+
X-Gm-Gg: AeBDietSO5GZCjwQrsadOtea94Weg0D1YXIxjQrhs8T3qJSy9tTOW4X1Sw9HijJNoMR
	uFah1Omo8r+S2k06hBQJd938zfLViYzqXzGze+eE2Gf+sH9VHrjl2XTeI2j4z5ul0EJZpSGQ5HW
	lSpgCy1foyqaUTtVjdwrA+eZEHo3K6MBOB+ubfZyCcmsi0xvZFk8Qp7ddFPYByrPQ23Y2EblzWd
	MbVDBn/7fVQOVwJF9SvQp5+yXgf66hqI37gZk6fWSLKli3nyhwE33FU13fNsQxwb9eqcrjReYmp
	A9vvmx8lXGSv+Pj0SAW3iUxeWxnuA3grkATGqYUIAVNF6lSs8UEPxjliOWZ1mtelNiPeLxP8kmC
	6MuKwM0eXOZ5RRTmlvx6xQeUzYE4a9bPLuAAX5zxG2UfTnUHQcZ1+o41YDsYRhdgBCFtnuzkbtR
	POxx3tZUNVSX6mlEyQRQmqBds=
X-Received: by 2002:a05:600c:c0dc:b0:488:aa3d:fab1 with SMTP id 5b1f17b1804b1-488d68364f2mr188027275e9.17.1776241210420;
        Wed, 15 Apr 2026 01:20:10 -0700 (PDT)
Received: from nsa ([45.94.208.74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3ebaf1sm2980604f8f.33.2026.04.15.01.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:20:09 -0700 (PDT)
Date: Wed, 15 Apr 2026 09:20:59 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	"Hennerich, Michael" <Michael.Hennerich@analog.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
Message-ID: <ad9J9C5K7tyxuztU@nsa>
References: <20260409-ad4692-multichannel-sar-adc-driver-v7-0-be375d4df2c5@analog.com>
 <20260409-ad4692-multichannel-sar-adc-driver-v7-5-be375d4df2c5@analog.com>
 <742b1821-9103-414e-a860-c2e8d5406e35@baylibre.com>
 <20260412185821.739e477f@jic23-huawei>
 <LV9PR03MB8414E0A68C5676302909E220F7252@LV9PR03MB8414.namprd03.prod.outlook.com>
 <b352b76c-8047-4a1f-8b83-db8144466c36@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b352b76c-8047-4a1f-8b83-db8144466c36@baylibre.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8581-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[analog.com,kernel.org,metafoo.de,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9DC03401E49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 10:02:31AM -0500, David Lechner wrote:
> On 4/14/26 9:25 AM, Sabau, Radu bogdan wrote:
> > 
> > 
> >> -----Original Message-----
> >> From: Jonathan Cameron <jic23@kernel.org>
> >> Sent: Sunday, April 12, 2026 8:58 PM
> >> To: David Lechner <dlechner@baylibre.com>
> >> Cc: Sabau, Radu bogdan <Radu.Sabau@analog.com>; Lars-Peter Clausen
> >> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> >> Sa, Nuno <Nuno.Sa@analog.com>; Andy Shevchenko <andy@kernel.org>;
> >> Rob Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> >> Conor Dooley <conor+dt@kernel.org>; Uwe Kleine-König
> >> <ukleinek@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>; Mark Brown
> >> <broonie@kernel.org>; Linus Walleij <linusw@kernel.org>; Bartosz
> >> Golaszewski <brgl@kernel.org>; Philipp Zabel <p.zabel@pengutronix.de>;
> >> Jonathan Corbet <corbet@lwn.net>; Shuah Khan
> >> <skhan@linuxfoundation.org>; linux-iio@vger.kernel.org;
> >> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> >> pwm@vger.kernel.org; linux-gpio@vger.kernel.org; linux-doc@vger.kernel.org
> >> Subject: Re: [PATCH v7 5/6] iio: adc: ad4691: add oversampling support
> >>
> >> [External]
> >>
> >> On Fri, 10 Apr 2026 16:15:20 -0500
> >> David Lechner <dlechner@baylibre.com> wrote:
> >>
> >>> On 4/9/26 10:28 AM, Radu Sabau via B4 Relay wrote:
> >>>> From: Radu Sabau <radu.sabau@analog.com>
> >>>>
> >>>> Add per-channel oversampling ratio (OSR) support for CNV burst mode.
> >>>> The accumulator depth register (ACC_DEPTH_IN) is programmed with the
> >>>> selected OSR at buffer enable time and before each single-shot read.
> >>>>
> >>>> Supported OSR values: 1, 2, 4, 8, 16, 32.
> >>>>
> >>>> Introduce AD4691_MANUAL_CHANNEL() for manual mode channels,
> >> which do
> >>>> not expose the oversampling ratio attribute since OSR is not applicable
> >>>> in that mode. A separate manual_channels array is added to
> >>>> struct ad4691_channel_info and selected at probe time; offload paths
> >>>> reuse the same arrays with num_channels capping access before the soft
> >>>> timestamp entry.
> >>>>
> >>>> The reported sampling frequency accounts for the active OSR:
> >>>> effective_freq = oscillator_freq / osr
> >>>
> >>> Technically, the way this is implemented is fine according to IIO ABI
> >>> rules. Writing any attribute can cause others to change. It does
> >>> introduce a potential pitfall though. Currently, changing the OSR will
> >>> change the sampling frequency, so you have to always write
> >> oversampling_ratio
> >>> first, then write sampling_frequency to get what you asked for. If you want
> >>> to change the OSR and keep the same sample rate, you still have to write
> >> both
> >>> attributes again.
> >>>
> >>> In other drivers, I've implemented it so that the requested sampling
> >> frequency
> >>> is stored any you always get the closest sampling frequency available based
> >> on
> >>> the oversampling ratio. This way, it doesn't matter which order you write
> >>> the attributes. In that case, the actual periodic trigger source isn't set up
> >>> until we actually start sampling.
> >>>
> >> Agreed. This is more intuitive. Now generally the userspace should
> >> be sanity checking the value anyway as limitations may mean the new
> >> sampling frequency is not particularly close to the original one but
> >> at least it increases the chances of getting the expected value somewhat!
> >>
> >> So to me this is a nice useability improvement given the code to implement
> >> it tends not to be too complex.
> >>
> > 
> > Hi David, Jonathan,
> > 
> > What I understand from this is that the osr should be taken into account when writing
> > the sampling frequency as well, right? Here's what I understand:
> > 
> > If the user wants a 125kHz freq with 4 OSR, then when internal osc will be written
> > to 500kHz before single-shot read, buffer preenable/postenable.
> > However, if the user wants a 500kHz frequency with 4 OSR, that would mean a 2MHz
> > Internal osc freq, which is impossible.
> 
> It is up to the user to request something that is legal. They should know this
> from reading the datasheet.
> 
> > 
> > More than this, if the OSR is 32 the maximum effective rate would be 31250, so 25kHz
> > would make it the closes available one. If the user would select 1MHz from the available
> > list it would be weird I would say. So perhaps a solution for this is to display the avail list
> > depending on the set OSR value.
> 
> Yes, the available list should reflect the current state of any other attributes
> that affect it.

IMO, the above makes total sense to me.

- Nuno Sá

> 
> > 
> > Linking the two together is perhaps wrong to begin with from my end, since in this
> > driver's case, the per-channel sampling frequency is controlled by the internal oscillator
> > which has static available values. So perhaps sampling frequency should be separate, and
> > OSR separate as well, which would make everything cleaner.
> > 
> > Indeed, the effective rate is changed by OSR, but perhaps that is something the user
> > should be aware of, since the sampling frequency is the rate at which the channel samples
> > (1 sample per period) and OSR is how many times the channel samples upon a final sample
> > is to be read. The user already has to take this into account when setting the buffer
> > sampling frequency, so it would make sense to take this into account here too.
> 
> We can't change the definition of the IIO ABI just to make one driver simpler
> to implement. The OSR and sample rate can't be completely independent.
> 
> If you want to leave it the way it is currently implemented though, that is fine.
> 
> > 
> > Please let me know you thoughts on this,
> > Radu
> 

