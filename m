Return-Path: <linux-pwm+bounces-6943-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDD6B19DF7
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09583A5564
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC101917E3;
	Mon,  4 Aug 2025 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J2KSrEKZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3751BCA07
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 08:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297393; cv=none; b=H82GjRDFTXEiIextxWJ6nSvS66/UCxQL36qKqqFUgaDNgwPfZlk+iPV+nBHO8kNay7XUBaQl6t1mRpZNYvX3oeUqJs06yKWZgzsbceBh9bDwu4FVNW5OF3oZjw/IhO7g86uEACyDmj6W9VNyE9lE9S4M/7gw1nhnC5AzA7RTAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297393; c=relaxed/simple;
	bh=wWy+JFHn9TTrt/BnNBPzBV4qBir5M7cDuw4hMnmgdGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rm1xKneJTR91BTQDcOl1vcy0bmedpJbPzBDRWiU055Yuy0WBxnsZY2CVjaUfDnyBlNSxAaZUc9B9wzn3swCkRy+d09YLfqPXT27XWT+caMm+LNLObOsHpcIxiWwObcIyBdmvHtzEphkqWREKFygdS870XwyVsrZXc1X+BudKeTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J2KSrEKZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754297390;
	bh=wWy+JFHn9TTrt/BnNBPzBV4qBir5M7cDuw4hMnmgdGw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J2KSrEKZXvkSw6awxmikCOT2fCqLzPNHtiawXMhKdCpw0utM0XPQbFAmkoT8LbEqh
	 XkfeeeOOPMg+VajPj4Uhv2vgoE2QTjw5o+oTgiUWF1q4opT/woI+AFXRiO8pck+UUM
	 Q3MX1x78Eu87ZTaa+a/Bjbv5zAgzGfbahiC+vNquyjYFW1crkQixRMaSZX6Qw3yySh
	 QrJhOmKCUccDqeoEWIcxv0Jr9MFd8boo61zhA5IAsD/o8lLf0WZDmMliMFy+IrPevj
	 GJxX6wAiKV4lr4SkDMqhFbm112t/2sjtKREDK8zXYVy5+Q9faZO7Dk+RlbtCVHx7dl
	 Z5z2Sw88h35fA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5515A17E0B8C;
	Mon,  4 Aug 2025 10:49:50 +0200 (CEST)
Message-ID: <8585fd8c-80d9-4551-862d-79b11defde0d@collabora.com>
Date: Mon, 4 Aug 2025 10:49:49 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] pwm: mediatek: Introduce and use a few more
 register defines
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
 <20250725154506.2610172-12-u.kleine-koenig@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250725154506.2610172-12-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/07/25 17:45, Uwe Kleine-König ha scritto:
> Instead of using a magic constant for bound checking, derive the numbers
> from appropriate register defines.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Awesome.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


