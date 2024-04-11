Return-Path: <linux-pwm+bounces-1893-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 393888A1333
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 13:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB997B21829
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 11:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBE914A084;
	Thu, 11 Apr 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri+HxRUr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618BF149E17;
	Thu, 11 Apr 2024 11:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835584; cv=none; b=do52KZPAa13S3Afy6chaxYePTEP9I33kVBsQroma4FTfs7KMWK4lZEKEUrHnbv5QqfrYD2kmeUgVSUPTRBZQod62wq/3M6u+Pmq1g3fHv3UAQE4Mm6AVfUD2jad7pYZxnAKRqHEmXuW2pmE7sHqyGCgy/TcCtXhtEJN5kG6lUcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835584; c=relaxed/simple;
	bh=X9vV5K79v2Fsvok6tE2lAzLxQa6MEqPuFqe5Gd+2Kr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jhT2w18fUDzHV8QDW8CCzmdZt1Wk4LVEjciS55RSlfApnBYwhf9QgxjKbeGNcV2qkdpqWll2YY0g7FpMCNOZNN48SWvfSgyYP9hZikxf/8rMbR7l4OxvD1HcxNlIUWYj3mRNMG4dI5ywIlo6LytsrXhY4zK0HwDE2aH8z4fzjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri+HxRUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629A0C43390;
	Thu, 11 Apr 2024 11:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712835584;
	bh=X9vV5K79v2Fsvok6tE2lAzLxQa6MEqPuFqe5Gd+2Kr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ri+HxRUr5vyTIfa0Unyvmv2zEC8qGF5cLrMibV08si52f6ZHji6gEMu5rgiw81Pfx
	 mD+rI6qNqEnXZmcc1JOmYqOc0IaJKv/fgnjxRYFJcYIN2TOG8sD1HzOR7x0ucW+lSP
	 1+w6CGAigsZGgZuobueP/ZQevDlDGhsZndaKji8yEshG3Dt8CApShNHq9NivFpzoYO
	 9i+yytz0HEWGm+262QBJIxr3/7zPtJXkTer7+LjhVDr369FrB9EKQkr5Ke/Hw/bePW
	 id7vDgr4xIrsdYM+bdxJzZ9wcodWF7pzHbjzpewhl3j8Jgqa9P4pG8pfiwRaHrTxTI
	 DW2Lb2kUsIufw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 kernel@pengutronix.de, linux-pwm@vger.kernel.org
In-Reply-To: <20240314113529.923708-2-u.kleine-koenig@pengutronix.de>
References: <20240314113529.923708-2-u.kleine-koenig@pengutronix.de>
Subject: Re: (subset) [PATCH v2] backlight: lp8788: Drop support for
 platform data
Message-Id: <171283558214.2316283.6027739768348217475.b4-ty@kernel.org>
Date: Thu, 11 Apr 2024 12:39:42 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 14 Mar 2024 12:35:28 +0100, Uwe Kleine-König wrote:
> The backlight driver supports getting passed platform data. However this
> isn't used. This allows to remove quite some dead code from the driver
> because bl->pdata is always NULL, and so bl->mode is always
> LP8788_BL_REGISTER_ONLY.
> 
> 

Applied, thanks!

[1/1] backlight: lp8788: Drop support for platform data
      commit: 150476e60a80ebb93d49aae7b636934eb04b83d2

--
Lee Jones [李琼斯]


