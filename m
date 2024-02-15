Return-Path: <linux-pwm+bounces-1509-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8746885590D
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 03:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF2828BE09
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 02:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECFB1864;
	Thu, 15 Feb 2024 02:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFFBBSuP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CC110F4;
	Thu, 15 Feb 2024 02:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707965846; cv=none; b=SxwYnpcvlZ+nupq/xY6FdngvZ6VgXBjhQKe13e6jc6gxkXsJu0Z724ZogIvoRVs0O4kQwAa4ncxw6KcAxcP0YRVIWRLtWKC10VLIQjTe1/sBAD3JU4QoYlGqkNPhMPaM2shnQewx+AptQGWe/BMOg0xn0py3mDQu1CIBLxavOi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707965846; c=relaxed/simple;
	bh=rYqnmUZ5+9xbel+3l+O0wrg1gYYowqllhJYmKd2LduQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVs91liJI4h9HHb5D47ggN8VH6fOvBUFRyfgb8A+jHlYuCKPhSd88tMRXdHxi5P55efIiY8dtm2GG5gt1MFf0GaSV15Hgy1FRbmEeh5hZk4xL+TJIPRkECEiazepHpViZUfJwVT1TaKRHxoedfn2zWBNQ3GriTJJQb8i5wOHBqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFFBBSuP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7E1C433F1;
	Thu, 15 Feb 2024 02:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707965845;
	bh=rYqnmUZ5+9xbel+3l+O0wrg1gYYowqllhJYmKd2LduQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IFFBBSuPIE+n0WD3VMLvDQn9iVbRFk3M46W9OSTGfBbrI6YTpf1KigdSCDIQlSGJA
	 +9lXh9h2fZe7Oz4Eyz3mRoSGpAVREhME12COAupPj28U3SgExsydFtUXjgvU3zKrO7
	 Q/IP+b6GHsk0KY0vReECK0E4iVIxjd60VQhZxOjvhxqFhvrX2dMvuKpzdsg7hCu5eF
	 LhHOb/6V1Zt0eZgc3ZVyI6GvuulACRTi9FRuqcr+wzAm6K+tJoZf5aNCQQdH9hpscs
	 nlI4r33f3UPmEEiK1dpx5JRBs3RxWWfICWp8qXcofe1/l9xGPIJt39iFTFv2Z36aqm
	 XATCM7JJHhUeg==
Date: Thu, 15 Feb 2024 10:57:22 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Benson Leung <bleung@chromium.org>, linux-pwm@vger.kernel.org,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v6 030/164] pwm: cros-ec: Make use of pwmchip_parent()
 accessor
Message-ID: <Zc19krZQidTKDWr5@google.com>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <486c40609bd9e339d7e5576e2501f63111b59b8b.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <486c40609bd9e339d7e5576e2501f63111b59b8b.1707900770.git.u.kleine-koenig@pengutronix.de>

On Wed, Feb 14, 2024 at 10:31:17AM +0100, Uwe Kleine-König wrote:
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, use the accessor
> function provided for exactly this purpose.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

