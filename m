Return-Path: <linux-pwm+bounces-2434-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6252904B8E
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2024 08:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7066E1F216AB
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2024 06:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20D168C14;
	Wed, 12 Jun 2024 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvKsI2x3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D132135A;
	Wed, 12 Jun 2024 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173659; cv=none; b=l/n0UNN9AfNAgY93pgZtYI76TWfHf29/D1AjMQtZKNAY9kZeZ8Yb4xDwWKr70cbNrdzK0omxnKIHYxcmVb+RLoF5ceybKjbhM2uvrynWwZRRWOFtuSMskRva5JzGNBl2gjt7l4GsHn8YJPREFoFwbdaR6uu8m6/JBmZ6IYaBxsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173659; c=relaxed/simple;
	bh=wjMkxgODRSVhoc7CGUWLcZ9JFijoyiOl0BbtskIy1BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SX/CMJBp2UMaM+vexzM+WJbhC253NJjyTuT8jOYlzJpxryTqQ+4QgU676fu1Ym8GFYuTgJBBwDHKpPhbQjHB2EPDLD4cnSifs0nZ/1d1/P75qHlqe7l0Ab4aogV8HJtZu194vxXU3yl7aLcAtIruvGHEGiV+o1dHr0lk1s0n79A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvKsI2x3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CB0C32786;
	Wed, 12 Jun 2024 06:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718173658;
	bh=wjMkxgODRSVhoc7CGUWLcZ9JFijoyiOl0BbtskIy1BA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvKsI2x3PrbMROweR4Yz+lVgjW/xrN/qDbsTrpVP3fzMGtF3UuaEuNWOzSnOlyD8l
	 3v3Dl/NUjpWPW2lpzA7DEIzBtgR+Z4J+iXbpDGmKGBTTmqMBKAanw8Mmbv2ngq/jto
	 LioyKgu0+7FVjIDZP7Swc2VSzCAzde+T3NK7tWeWqMzeCVB6o72R00vYdVoqNR7LuB
	 bv9SSeu2iRITh5BXVp/Rho9x9UbV5MLUmd9PJGHS9Ik8Pbj/AyXIdNtN3T9TzqoxgX
	 6WeIyHa39/QteaPIz6kJC/DBIpZxrYhC8bHDFeIp+d4b4zPiTP42vgy9oVDEuPD/TT
	 afMzZ48oy/1KA==
Date: Wed, 12 Jun 2024 06:27:35 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@baylibre.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] pwm: Make pwm_request_from_chip() private to the core
Message-ID: <Zmk_15E2K1KrVXU7@google.com>
References: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
 <20240607084416.897777-8-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607084416.897777-8-u.kleine-koenig@baylibre.com>

On Fri, Jun 07, 2024 at 10:44:17AM +0200, Uwe Kleine-König wrote:
> The last user of this function outside of core.c is gone, so it can be
> made static.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

