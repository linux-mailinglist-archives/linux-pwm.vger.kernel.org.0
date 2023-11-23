Return-Path: <linux-pwm+bounces-171-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9607F5FDE
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 14:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0840F1C20FBE
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Nov 2023 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679F124B22;
	Thu, 23 Nov 2023 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bfwnHsr3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D5249E7;
	Thu, 23 Nov 2023 13:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96A3C433C7;
	Thu, 23 Nov 2023 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700745314;
	bh=VMwR96iPuDm2xucRtdyxV6XCVoVFjQ6uXBqmca88So8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bfwnHsr3n+04XxPSrm2+dz8sNeuQgAZpdCgE4WBAwju6o5jbwApU6DehqKy8Vd3tx
	 gSKPZ6xxzMas54dLQyfuBMBD2nspyY2+AQ6M+1/+xzR/no7N6lHkTtUTgWWQLbHQfN
	 7xTXxZHfSAtG9xG4Kj0tjsaUeJBW4YyaaDKACSoE=
Date: Thu, 23 Nov 2023 12:55:29 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 036/108] staging: greybus: pwm: Make use of
 pwmchip_parent() macro
Message-ID: <2023112321-mandolin-bagged-d6dd@gregkh>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
 <20231121134901.208535-37-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121134901.208535-37-u.kleine-koenig@pengutronix.de>

On Tue, Nov 21, 2023 at 02:49:38PM +0100, Uwe Kleine-König wrote:
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, use the macro
> provided for exactly this purpose.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/staging/greybus/pwm.c | 55 +++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 29 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

