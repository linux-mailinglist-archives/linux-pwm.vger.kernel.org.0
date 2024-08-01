Return-Path: <linux-pwm+bounces-2954-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5D7944B55
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 14:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6C41F222BA
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Aug 2024 12:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E85D198832;
	Thu,  1 Aug 2024 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDe5rfuX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F3143C42;
	Thu,  1 Aug 2024 12:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515512; cv=none; b=WFwM+Cq1SvMsps13Wzf/TtaFV42OfQr4wgoRjsU26U1kaU6hSLTqiEGQ+Z/KIDXOXpq7xWIqL4zNcWngTHBfqUGZLzfTA9ms/7tKVGOzpy3FxJw0oiYje4OrHbmQMWB+1zctvC0Pd3cgnkoOfHHuVdOkaBOfIEXzcHwZ+aEKV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515512; c=relaxed/simple;
	bh=ZjQuBDumfc/DgkWQGmObSG2aAiMcovJ0npp+N3X9kwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYo/eTBGF3AmCITjZ4+HjAahRZy+YIR9EhfwYDP4e50o7fN/cqPl+B/3UJ3ML9or89FVFZShF6hFip357P+zQMtMnDRl6QPKwMJR6HKrfkgf2dBlBykqB5qE3sPkN4coFM0OVFQiGE4xSDTdFaeIDYbr7ma/wzKYXtIiHRL6zog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDe5rfuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2212C4AF0A;
	Thu,  1 Aug 2024 12:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722515512;
	bh=ZjQuBDumfc/DgkWQGmObSG2aAiMcovJ0npp+N3X9kwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDe5rfuXsj6HdkLVTT5zLVTRnJxyeVMzODaxsf1CrRy7PhL0LaD4drQqVKUBJvqM7
	 lwojFwJAkMnmzVXKqdlHJXidx88D/9wN+jWMMnYdhR4jVDavvpgrzFcIAmgLrwgXxI
	 PYmpoSnxLclazfAl8ndhtFEnx/WyF1RD0283anZZXv7OHNWX2WIFmTB+lMwQLOp/a4
	 7JIwCmPyfFNuAdZeloplWCOCZErkWLJVRUfExIhkN3ApbQRmNeT8bjYN/ysitFaaEH
	 xLEW20oMTmiU5YXZcyMPJsDo5BfURlOGiBzYN9IWSrtKrLuS6mlszGKBKI/xzMny9K
	 +k7FOH2wYDjTg==
Date: Thu, 1 Aug 2024 13:31:47 +0100
From: Lee Jones <lee@kernel.org>
To: Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martin.kepplinger-novakovic@ginzinger.com>
Cc: ukleinek@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: print errno for probe errors
Message-ID: <20240801123147.GA6756@google.com>
References: <20240801091255.1410027-1-martin.kepplinger-novakovic@ginzinger.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240801091255.1410027-1-martin.kepplinger-novakovic@ginzinger.com>

On Thu, 01 Aug 2024, Martin Kepplinger-Novaković wrote:

> This makes debugging often easier.
> 
> Signed-off-by: Martin Kepplinger-Novaković <martin.kepplinger-novakovic@ginzinger.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Please refrain from signing your mails like this.  It means that some of
us have to physically click a pop-up box as we are parsing our inboxes.

I'm deleting all mails in this thread.

-- 
Lee Jones [李琼斯]

