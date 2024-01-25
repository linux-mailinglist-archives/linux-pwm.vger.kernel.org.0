Return-Path: <linux-pwm+bounces-944-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 255AA83C0BF
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1131F218EE
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 11:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247D42C68E;
	Thu, 25 Jan 2024 11:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R7vBpMqO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EA2C684
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 11:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181969; cv=none; b=jFqhacdKDTmwHltPPvdxWHZ3Gf6lCB1XGyW+45eeNsynHTPp1aArc3Kbu2QVVmqsSDuRnF1sBN7jc+7716iy0DNeBpsZR5mMYnmtYv8lbNlooy6hLLEM7fgYncMnWx5utewJFagirP2o0NDcSsgIsmzoGnPHuAI+SDQkhudIax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181969; c=relaxed/simple;
	bh=9G80+GECq48W/Xf3HqDt+OaUbZB2584sod+5BUxsKtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5jQQ60ZbeEGty6rSOv7pIV/bkTCb9yEhVAqBZm+iuGGk7MEnLFmGyaO7Nmir/yOF1ukqeEW4dG7QhJhKMdG6GqVw6uXuRsqVLxmLIscJviIJI2naidxY1KprzQ/ge2nMJgEj7LyznOHTwRL1PwAsPrQ8Cwdv0EZuMhbkm+FXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R7vBpMqO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706181964;
	bh=9G80+GECq48W/Xf3HqDt+OaUbZB2584sod+5BUxsKtA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R7vBpMqOde3jaA3fHeVBIjCbpc8fyuXilcUd5xGS0IZ/dbgb2ZCzuuwC7pKvopoPA
	 Wf5UQY9Z0ZKz4dOyIuqGzixN32gZ4r26SEZeBwAUM9A8aJXv98nHlCYQze/aP0hbVm
	 7gD6OHQeys6HZemTmmuJ10TAeMbpC7VJzGBeZC4ncjFPsUN2sLh/Ke03GqG+G9fU2C
	 qI2dkn5FClunBpsA9YTphh03d2aSMl61HTEmzrNmDWLBouCOiH9HQH/zFSQR79s/Sn
	 Mio1LzhFF9+t+mu4bGU7xVMna8mlxitkFrkfa8caNTkfoifNLw3Mt4UDwdv1AZnY/Z
	 mFjaxIbm+1rSw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A96653781182;
	Thu, 25 Jan 2024 11:26:03 +0000 (UTC)
Message-ID: <9f910e07-6af9-45e2-ab02-d3467e650623@collabora.com>
Date: Thu, 25 Jan 2024 12:26:03 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: mediatek: Update kernel doc for struct
 pwm_mediatek_of_data
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@pengutronix.de
References: <20240125085649.1571268-2-u.kleine-koenig@pengutronix.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240125085649.1571268-2-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/01/24 09:56, Uwe Kleine-König ha scritto:
> The struct never had a member called clk_freq. This fixes the W=1
> warning:
> 
> 	drivers/pwm/pwm-mediatek.c:60: warning: Excess struct member 'clk_freq' description in 'pwm_mediatek_chip'
> 
> Fixes: efecdeb82f21 ("pwm: mediatek: Allocate the clks array dynamically")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


