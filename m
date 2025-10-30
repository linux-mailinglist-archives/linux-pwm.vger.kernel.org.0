Return-Path: <linux-pwm+bounces-7536-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB73C1FE11
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 12:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9BB9C349BB2
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 11:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B32231197A;
	Thu, 30 Oct 2025 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJ4psI5M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39F23D2B2;
	Thu, 30 Oct 2025 11:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825006; cv=none; b=RXnxhLXWNCr7MKtxdfsvKN8EM4L88L36l9qbbY9+rpnNd2SSeVq6d4XzpyWbuFe7Sji4BXK76wqLMLvdU8p056vgFJ0OWq060vivzfxV31draPwLk8q0G+hssje3pnvNEIbdOLhtJDztm7h0852ybgA9tQ1pX4Bvfbc9DUoQI00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825006; c=relaxed/simple;
	bh=moMPcJsHoh+D5tFeCvN/Eh1IJ6XaSFfSJQcEu0+Vvog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duVrZXYC81pWDHsvrMLHghY/7n/9KOxJ6ppqRu4UWDtkIJbILkRHCDgnePA21sgIt2jueWcO0w4HKwLH+QmmrFdT2kvH/bokQNoXl0i45GoCLp2C7UspD7yoAE04GnZY9xQlUeoDNVecd3s7XT2lvdVyiQklP9517joAwq7hWOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJ4psI5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D596C4CEF1;
	Thu, 30 Oct 2025 11:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761825004;
	bh=moMPcJsHoh+D5tFeCvN/Eh1IJ6XaSFfSJQcEu0+Vvog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SJ4psI5MuXqxCO245p9pGERpCQi5pHOVlT7DSYUE/R4AZa/VnB170AnM6D47963zL
	 H7ilQkhTy9xoyz/JbV1n9FQzp2hjWkNHqtj1iq8zRYPg+BIefMMJetoKH80QG1JmnO
	 JT+xhsXNTO53e95Gq/dgJyvDnQ9ICtITcXrSi5WiIfRBykNaMFHlUTWFqbKizHDtd2
	 TAD1nYg1xr1HDhsI1Zvt9UTUGTWGoU1wvjHAlFGpAVPuK47N3Z20abhOA9xA28jVVK
	 O6Bmr69H7I5bVwYirMdP7n7ALFwT9pMEWTetRVwDQUnd4s1k5MflOTV+ZtM2AX9qC4
	 LTOXGvLmfxt6A==
Date: Thu, 30 Oct 2025 11:51:07 +0000
From: Daniel Thompson <danielt@kernel.org>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>, Pengutronix <kernel@pengutronix.de>,
	linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: apply the initial backlight state
 with sane defaults
Message-ID: <aQNRK5ksNDMMve0x@aspen.lan>
References: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-blpwm-v1-1-0171fd31bff9@pengutronix.de>

On Thu, Jul 31, 2025 at 10:47:18AM +0200, Michael Grzeschik wrote:
> Currently when calling pwm_apply_might_sleep in the probe routine
> the pwm will be configured with an not fully defined state.
>
> The duty_cycle is not yet set in that moment. There is a final
> backlight_update_status call that will have a properly setup state.
> However this change in the backlight can create a short flicker if the
> backlight was already preinitialised.
>
> We fix the flicker by moving the pwm_apply after the default duty_cycle
> can be calculated.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.

