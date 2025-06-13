Return-Path: <linux-pwm+bounces-6343-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C70AD8F45
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 16:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F55216A585
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jun 2025 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADFF170A26;
	Fri, 13 Jun 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYE4QuqY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C582E11D8;
	Fri, 13 Jun 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749824124; cv=none; b=D4434tC1zrYj+xnLfPpnFIfaNsvu7aD2um9S5mc9qNOjHubaTbGFj6/+GCNSyCis/eh6zD6roRAsA6j5WIpsmw9ICTavlGGpPl/g4dxsU5HbjrIg1w2g/jQil2wteMNhdZhi2mVUlKeFFfId0xI7hHqVVEsdZjb0VFF6m0XYqRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749824124; c=relaxed/simple;
	bh=cuekvKuodAn/cGpNTMhG5VZfX56fxI4VzRxlFbLFFYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6UvGxbbPLjoiqhkYV6nKdzOTsiLggsr7Otg+IC6vytgHZshR9hVwzLtSHADfepDGwTNkUz8psn7j1O9pmp/G6lTtmNsyFpmKCNpHkicgjW3ZhDbaxrL5AUpjkVktYnhMLSNOrMtMpXokAbTxeW15sqWIfTsagZD4au/Qk6z6q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYE4QuqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FA0C4CEE3;
	Fri, 13 Jun 2025 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749824124;
	bh=cuekvKuodAn/cGpNTMhG5VZfX56fxI4VzRxlFbLFFYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sYE4QuqYAV4TW8H9u/uEh1p7jeIk0/4P1yqSwbR0PurZj5B5HurOZmlfAWKoYJq2q
	 linnNymYEo2hZOrlU2zb77t3/YWIR2eMVohcSYJy93Iw8lHFTlOILiP3CzRi/fQbt7
	 WPodGY9fYWMsfNFOgxdyme9qmB5/9EEaLZuGHBrBFbhwSiSvDHGCvPoWDLxr6yCMR8
	 8lTg5ecFDVeZxJN8r5iBtRt5/QWWnsdsMLR/PtBMJ9kmJprRBNw4uhHgbmdzejIeX/
	 UXFjWkf+IfnRaMD574HvOcwn4pm5m4oSLAHl8xRkKWVZuexr7U2oLQPQ84pZiMyny0
	 EqovJndksA21Q==
Date: Fri, 13 Jun 2025 15:15:17 +0100
From: Lee Jones <lee@kernel.org>
To: mathieu.dubois-briand@bootlin.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v10 02/11] mfd: Add max7360 support
Message-ID: <20250613141517.GH897353@google.com>
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-2-ce3b9e60a588@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530-mdb-max7360-support-v10-2-ce3b9e60a588@bootlin.com>

On Fri, 30 May 2025, mathieu.dubois-briand@bootlin.com wrote:

> From: Kamel Bouhara <kamel.bouhara@bootlin.com>
> 
> Add core driver to support MAX7360 i2c chip, multi function device
> with keypad, GPIO, PWM, GPO and rotary encoder submodules.
> 
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
> ---
>  drivers/mfd/Kconfig         |  14 ++++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/max7360.c       | 171 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/max7360.h | 109 ++++++++++++++++++++++++++++
>  4 files changed, 295 insertions(+)

Looks good to me now.

I suggest this series goes through MFD.

Ping me when you have all of the other Acks.

-- 
Lee Jones [李琼斯]

