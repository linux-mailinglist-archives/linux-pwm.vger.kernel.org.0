Return-Path: <linux-pwm+bounces-3924-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452119B1C9F
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Oct 2024 10:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7497D1C20B14
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Oct 2024 09:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8017346D;
	Sun, 27 Oct 2024 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="petV00lO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80E14D8D0;
	Sun, 27 Oct 2024 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730020517; cv=none; b=Cng1H/YAk1LK6YOI3lgteBv+vQZmC6cDNuAzXojtKzhb2g1M+trD9WtTwYrpKoeUAVualWpLzZEajtwBgIyRBlVIZSMoCXCyR7cosIgDvz/xC1VwDqoNe5Aq1ctJp+gss5tIz9fzLEVQ3DDiuxv0nXoYcuy6869LQCyMjtRTlaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730020517; c=relaxed/simple;
	bh=7oSbF6G9EUyIRrZ6g+8ggLmaKMcWLUykTzf5luUKV5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhsOfNLixyPTq1XQxDuUvapRZYpRlhTbR9jnmaAv6HAoHok2L07IJrM1p292EPpGdcesZvQmTnafRgz1yFoi9lcl4wdYxKFwjqNQVlTyfgCzA2BoHaOfU54z0HCZA27UE+5M1VOTnZNcWQj6qq1q6kJhBtp2dqE08xJiIwzM4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=petV00lO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179DDC4CEC3;
	Sun, 27 Oct 2024 09:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730020517;
	bh=7oSbF6G9EUyIRrZ6g+8ggLmaKMcWLUykTzf5luUKV5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=petV00lO2Y9O41ktOH0ZptuZpz2PbV6eCHtaaf45tUSQqzTEdBYXqDtlYTl7UUMM6
	 az2RqkU2WnTNENSzCqkXBNeDDErGGeGj4OBGXpAAX8HWMKtkplz92DvwmmVtbaVk/E
	 uKcPs/LkBdQV9wSylLsLytU2uZtE3i4avhTCa9krwizXArGmalnTrXnwMccXowz/2/
	 oYVXucF5PzxUPRVDnuh8FjYMpyAR+fy7DEoJyordJpyUxWVrs/BAt/vvhZ2WerRX4C
	 MX5UdG3PG1SoXbdCS/HddciyzNMZhVENlm9s+tySRxDfa5+JcmjzKaqsJQGglBMwzR
	 tRc9mgcH2ctDQ==
Date: Sun, 27 Oct 2024 09:15:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org
Subject: Re: [PATCH RFC v4 15/15] iio: adc: ad4695: Add support for SPI
 offload
Message-ID: <20241027091508.2572785a@jic23-huawei>
In-Reply-To: <7700b27a-9ffc-474e-8390-a69428fe7607@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	<20241023-dlech-mainline-spi-engine-offload-2-v4-15-f8125b99f5a1@baylibre.com>
	<20241026170038.4b629cff@jic23-huawei>
	<7700b27a-9ffc-474e-8390-a69428fe7607@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Oct 2024 19:05:44 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/26/24 11:00 AM, Jonathan Cameron wrote:
> > On Wed, 23 Oct 2024 15:59:22 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> 
> ...
> 
> >>  static int ad4695_write_raw(struct iio_dev *indio_dev,
> >>  			    struct iio_chan_spec const *chan,
> >>  			    int val, int val2, long mask)
> >> @@ -779,6 +992,17 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
> >>  			default:
> >>  				return -EINVAL;
> >>  			}
> >> +		case IIO_CHAN_INFO_SAMP_FREQ: {
> >> +			struct pwm_state state;
> >> +
> >> +			if (val <= 0)
> >> +				return -EINVAL;
> >> +
> >> +			guard(mutex)(&st->cnv_pwm_lock);
> >> +			pwm_get_state(st->cnv_pwm, &state);  
> > 
> > What limits this to rates the ADC can cope with?
> >   
> 
> Nothing at the moment. The "obvious" thing to do would
> be to limit this to the max rate from the datasheet.
> 
> But that feels a little too strict to me since maybe the
> PWM can't get exactly the max rate, but can get the max
> rate + 1% or so. It seems like we should allow that too.
> It's not like the ADC is going to not work if we go a
> few Hz over the datasheet rating.
> 
> Maybe limit it to max + 10% or something like that?

Clamp it at datasheet value.   That's what is presumably verified
not 10% over.  If that needs relaxing in future, the datasheet should
be updated to reflect the higher verified value.

Jonathan


