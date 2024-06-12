Return-Path: <linux-pwm+bounces-2432-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC4D904B8A
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2024 08:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D57A9B22943
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2024 06:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3D0168C10;
	Wed, 12 Jun 2024 06:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENojhtNN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C46167DA0;
	Wed, 12 Jun 2024 06:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173638; cv=none; b=n4mfMsDv4odII1kUdmWfgnP/AJbapscOigPWs+c8YH5YN7/E/o7JD5MtT+cl+nGbRANVVPTzVOtCpSdeucEFDQFrbiM95whlAMej1KmukHXUomXriDlx8KVx0v7/WKOpxxi9sxE5ev8k2J2QRvCV3Uci7J4+NU6WcBXXwcG1W+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173638; c=relaxed/simple;
	bh=e2ENKQIsTaX0sTudk2hGDKHVUGSIjiOwmVg8cJI75PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUYbkFTnA8+j33+H2wh2wLFrEyONsdYCi6BFxc28Q3uDVw3cCCsCjcHevRmmjy7GuWZGxZ1Tw9PjNNOL9B8xq2p9DaLXcVM9tS7A2udq+RRgv3T1oAWzCfeJfMAm6Hjfm+KRnNBB48QK8PrJSW8nZ/heKXRLtT+j6h7H27Ih19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENojhtNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66683C32786;
	Wed, 12 Jun 2024 06:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718173637;
	bh=e2ENKQIsTaX0sTudk2hGDKHVUGSIjiOwmVg8cJI75PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENojhtNNGHdNYOnPQN1MFhFOstveOWidJQ7t/Y8POhDUCxRHat45JPNjaJiyOAs+r
	 v/1sB3eR9c8Ywl85QTXifc6beSGNWx407WniIbbLEKEJ6gKG/GcbpneurWzfMx6FfC
	 iQY12Mh9xYE45kRCnWQrAjpKtErCt/IlXpLBTWt6fR4vHF6YHZJXXRrwnaDw22mHM5
	 lN0k7QZ+7Ee6+yNGTHmFioyGClrPmFBNiUzlSvZEw+pW9lhnHCaOK8SIpuuOkUs2Sp
	 bHiLLdc9srG4e+P75deeQisFR4fO6LOBnIYgN/5VStYxYFkDHsHP2xdvGNYeqi/x3z
	 pbIB3o0CYQkDw==
Date: Wed, 12 Jun 2024 06:27:14 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: cros-ec: Don't care about consumers in
 .get_state()
Message-ID: <Zmk_wolV5vK4JPCV@google.com>
References: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
 <20240607084416.897777-6-u.kleine-koenig@baylibre.com>
 <ZmgP5NTPEGM0M2Li@google.com>
 <dbygoq4rzxnzforpdsvuy5jze2rxqszi6qxtx6q37yxwjo36o6@qfoc6iz2nbay>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbygoq4rzxnzforpdsvuy5jze2rxqszi6qxtx6q37yxwjo36o6@qfoc6iz2nbay>

On Tue, Jun 11, 2024 at 12:39:44PM +0200, Uwe Kleine-König wrote:
> On Tue, Jun 11, 2024 at 08:50:44AM +0000, Tzung-Bi Shih wrote:
> > On Fri, Jun 07, 2024 at 10:44:15AM +0200, Uwe Kleine-König wrote:
> > > The get_state() callback is never called (in a visible way) after there
> > > is a consumer for a pwm device. The core handles loosing the information
> > > about duty_cycle just fine.
> > 
> > ChromeOS EC has no separated "enabled" state, it sees `duty == 0` as
> > "disabled"[1].  1db37f9561b2 ("pwm: cros-ec: Cache duty cycle value")
> > caches the value in kernel side so that it can retrieve the original duty
> > value even if (struct pwm_state *)->enabled is false.
> 
> There is no need to cache, so the following would work:

Ack.

> > To make sure I understand, did you mean the original duty value could be less
> > important because:
> > - We are less caring as it is in a debug context at [2]?
> > - At [3], the PWM device is still initializing.
> 
> It doesn't really matter that this is about debug or initialisation. The
> key here is that the core can handle the PWM using duty_cycle 0 (or
> anything else) when it was requested to be disabled.
> 
> 
> > [1]: https://crrev.com/0e16954460a08133b2557150e0897014ea2b9672/common/pwm.c#66
> > [2]: https://elixir.bootlin.com/linux/v6.10-rc3/source/drivers/pwm/core.c#L52
> > [3]: https://elixir.bootlin.com/linux/v6.10-rc3/source/drivers/pwm/core.c#L371

I was trying to understand the description in the commit message:
: The get_state() callback is never called (in a visible way) after there
: is a consumer for a pwm device.

I guess I understood; the core reads the duty value via get_state() when:
- Initializing the device for the intial value.
- Debugging for checking if apply() really takes effect.

What 1db37f9561b2 worried about is already addressed by the core[4].

[4]: https://elixir.bootlin.com/linux/v6.10-rc3/source/drivers/pwm/core.c#L495

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

