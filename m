Return-Path: <linux-pwm+bounces-1484-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0422D854758
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 11:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3720D1C2763B
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C2D1863F;
	Wed, 14 Feb 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hZxxYksu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32DEEAA;
	Wed, 14 Feb 2024 10:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907249; cv=none; b=PsYC0MAzA83S6s/EnSFRPlafNB5IUkSFA5MLAhs0Orz71k4TodtVUDjF10xgN8AOHN+g1r7WJ4H6DwWTXOl2zZhTHSyPSILtvLkpx3yI30DRBqlr4O12tNvInWiyGkg0lPhJ/tF6AUxLadc6L+4U3mjnww6QBnHz8Mx8MmTI6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907249; c=relaxed/simple;
	bh=ykn/AluRju0yZPnLVn3ZXykR4Gng1pt8ZT1uj0mZCWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbbAX8JbEZVu72ZsgqhdFOlF+6egbLdvalT8Lj8fvyaCFVnTyt9bOA1lhclgnpRnHgvYfpgfHmLYgHvAICcX+NKhPNN30bfJ4axJp9ZuibZFoDbCC3vRR/Fp2Fz0t6G7qpswwQJgyoR8tR6YFmf9llFznn5ZhpcvkA6iXRufnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hZxxYksu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D44C433F1;
	Wed, 14 Feb 2024 10:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707907248;
	bh=ykn/AluRju0yZPnLVn3ZXykR4Gng1pt8ZT1uj0mZCWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZxxYksuG9A/ueBJcAN4oygN2OlIoveF0cEw3NLCC0oUYAMi5ZgkRBi5VoRjIQJIJ
	 oRG5hkHBcTxqcJ5h71RsNra3dtdTfkYbHkhlmyK25rEgdOXkMGtA1obH8VWaYFTuQH
	 wZs1L6sE01Nu9BJK7YCnPc7i0aLDh/pXm4oxeXFo=
Date: Wed, 14 Feb 2024 11:40:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v6 157/164] staging: greybus: pwm: Rely on pwm framework
 to pass a valid hwpwm
Message-ID: <2024021439-module-seismic-86dd@gregkh>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <e003bc5e8e66f27f2b8fdc525a536d865888cffe.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e003bc5e8e66f27f2b8fdc525a536d865888cffe.1707900770.git.u.kleine-koenig@pengutronix.de>

On Wed, Feb 14, 2024 at 10:33:24AM +0100, Uwe Kleine-König wrote:
> The pwm framework already asserts to only pass a hwpwm value (= which)
> less than npwm (= pwmc->pwm_max + 1). So there is no need to recheck
> this condition. Drop the respective checks.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

