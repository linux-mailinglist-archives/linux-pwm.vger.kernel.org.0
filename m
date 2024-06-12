Return-Path: <linux-pwm+bounces-2433-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34666904B8C
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2024 08:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D85D1C220F7
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2024 06:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4AB167DA0;
	Wed, 12 Jun 2024 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgDEVnwC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19562135A;
	Wed, 12 Jun 2024 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718173649; cv=none; b=ISV1I8R6Nt+LkdCLm9zG0e+5Vzkd6j/9JHjE7BMSdBDSeGkYHCO0FtdakFDHg4/E9bQ5h4otnqVqU3xXbugl0pNt/RTfDJ5q5Q068fQbR1YDtILPscaFR02zbuXuQ75Ra8VtbGDTQ/At1H9WaQ27Bcxipk7uUO17IDbNUAr+wPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718173649; c=relaxed/simple;
	bh=1o7QKvF1Unm8odLYa5VE+NAxXl1A/eOwVf8+HDls9LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4ZIKIAgWpLN+RA41+anpXmk9E1G4zaPehZ/UWlro2DDZeoZvKGAjIYms1utcoIBNFSr0Q2UiZqOta0miJ4cM6s1f9m0ZgelZWNScnTdzYTucIYAZkT7FIBqQygqGVCMjs2kC4EgYC9cbIhifrfeskK30aGcQGd+Cp0maSfO+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgDEVnwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D44FC32786;
	Wed, 12 Jun 2024 06:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718173649;
	bh=1o7QKvF1Unm8odLYa5VE+NAxXl1A/eOwVf8+HDls9LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgDEVnwCFJooSXfI0OKC0SUAtIv8D6P4smJsAFQkte1ST+X0kK0ygyuhJ2QsXOG44
	 qJujIResqBEmp8EfxvkqWO552iLqr4VheJzLlrlWTeanQ8KB/VAsUluNZLsATwvAIm
	 PmdiawDmN5QXy6hPAdh/HuVwwRKT6/BlsmmI+ucvOopqo64j8P3evo6K6PGkkH8OKS
	 umwUF2yE3c0uypx66dPuZfUDwyXz4CLlBG9e8ssfsJvh4PqGeU7P/esigRAbK5jpVE
	 CQGMtwaV0JQ5is3ZSM5Mr+Rw6Vuie2PGYnUNRLozuHdAWvZLi9TQyoEj5Go5YbScvT
	 BE+P66d6u5q4w==
Date: Wed, 12 Jun 2024 06:27:26 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@baylibre.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] pwm: cros-ec: Simplify device tree xlation
Message-ID: <Zmk_zmlyulWRejc7@google.com>
References: <20240607084416.897777-5-u.kleine-koenig@baylibre.com>
 <20240607084416.897777-7-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607084416.897777-7-u.kleine-koenig@baylibre.com>

On Fri, Jun 07, 2024 at 10:44:16AM +0200, Uwe Kleine-König wrote:
> The cros-ec device tree binding only uses #pwm-cells = <1>, and so there
> is no period provided in the device tree. Up to now this was handled by
> hardcoding the period to the only supported value in the custom xlate
> callback. Apart from that, the default xlate callback (i.e.
> of_pwm_xlate_with_flags()) handles this just fine (and better, e.g. by
> checking args->args_count >= 1 before accessing args->args[0]).
> 
> To simplify make use of of_pwm_xlate_with_flags(), drop the custom
> callback and provide the default period in .probe() already.
> 
> Apart from simplifying the driver this also drops the last non-core user
> of pwm_request_from_chip() and so makes further simplifications
> possible.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

