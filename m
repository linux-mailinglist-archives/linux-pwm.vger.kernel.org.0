Return-Path: <linux-pwm+bounces-4923-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D69A37456
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Feb 2025 14:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA713B047A
	for <lists+linux-pwm@lfdr.de>; Sun, 16 Feb 2025 13:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7175619CD0B;
	Sun, 16 Feb 2025 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uri+nh3t"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D219CC34;
	Sun, 16 Feb 2025 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739710736; cv=none; b=rl7bWGy7kd4iw+dgyMtvLl2GT9S+d5lf2hXK1M7yFXT1RMDBwn4layy9aewRubIxACJMAsadWwFAgchevyR+7HaOPimuzg8klGa8Bf8wAwKCRqJhE/hVtD9JFxXHlosZGmoaUkxYlXlseqaJ5n7VN/Z7w/RotFAmtG/n/wvFYdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739710736; c=relaxed/simple;
	bh=MZYk+9ELkvvFCA/Jtc4bdd7gkUCtekZlBhj5EOkixlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jumAB7v5/lKNBh342zbJEda7BKBxAvho/oRf0g3NzdmqMqAfHDE2nF/60Vl9Gy+V/5RT9Hnd2GnHw2PFIvlUgTKIb7Xij3XzkA6WCAR/cP1IzDfQjUJ1Dfkn3VTf/18wIGLnzhVRFB0//3Y26i2tFWSn5p852oN9b1ivFGhuFN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uri+nh3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC349C4CEEC;
	Sun, 16 Feb 2025 12:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739710735;
	bh=MZYk+9ELkvvFCA/Jtc4bdd7gkUCtekZlBhj5EOkixlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uri+nh3tlE1lvXTcnbMflBKk6EAZcnAKS8hMVADfwwHydoZWIv04BdRXH4hHENfVU
	 81q05QiZRQXNASlhJ56wb9s6pwLO06wlWUFv3uGIb4I1Ygnif4RaaInuuCGHv4fFsf
	 bhvYRTrTej8zpwK5fsEHgvJAN15WvNyWthFVjV8jbymKMnp1vTNxLdqsodFjYA8jVI
	 0a4faL8qxSVh8OHF7nxG0t1JLV3PBT4oB4Ql0ElCQtFAg+ZYJGYXFGW572bMNpC7jr
	 LwDnZceaazUbpMqyVpHg9a2QylZefcmGfr2L58qfs2zUWW4Xp2s/edbk/7S+qJUTSW
	 43nKNu1vGI+9Q==
Date: Sun, 16 Feb 2025 13:58:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
	=?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 01/10] dt-bindings: mfd: gpio: Add MAX7360
Message-ID: <20250216-lavender-goose-of-variation-6b5efb@krzk-bin>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-1-8a35c6dbb966@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214-mdb-max7360-support-v4-1-8a35c6dbb966@bootlin.com>

On Fri, Feb 14, 2025 at 12:49:51PM +0100, Mathieu Dubois-Briand wrote:
> Add device tree bindings for Maxim Integrated MAX7360 device with
> support for keypad, rotary, gpios and pwm functionalities.
> 
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  .../bindings/gpio/maxim,max7360-gpio.yaml          |  91 ++++++++++++++
>  .../devicetree/bindings/mfd/maxim,max7360.yaml     | 139 +++++++++++++++++++++
>  2 files changed, 230 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


