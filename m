Return-Path: <linux-pwm+bounces-7850-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE394CF4F42
	for <lists+linux-pwm@lfdr.de>; Mon, 05 Jan 2026 18:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AD9B30D04A3
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jan 2026 17:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8CC3054F9;
	Mon,  5 Jan 2026 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ni28G60F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE9322B90
	for <linux-pwm@vger.kernel.org>; Mon,  5 Jan 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767632957; cv=none; b=YKZUsdp3+T61YvtfNBV6q3Fp5lvb1wIbSDZ0sKBCZwGezZbbMeqfQCgJqIiRsFQcY8VtDKReOyQL8iTFrOd5FDTyiX8a7EVDL/FWyghgRtT8hMtoilaeJVn8t3gU2Q6RKWKEs2SXZpeWz12PcIpQZbkO7Q1zLX+hw49SfDpmQTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767632957; c=relaxed/simple;
	bh=AI1wYPw1WSz5qgZsJPGfst+nTTz8MG0P3bfm7SX7V1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Xvy3cHLOc+d8Z0Bdw6aNia2hE9MdypB0D+h1wu+JhAwA8hzuAaOi70nSIhZMSfF/Frzwi6QFl8bZbRfDghoidgQJJQblEnuvzGSB9+LxM+ShcUZTVbtO8hZyTIj9fiAdcZOu1LlXwEYKiwBMdPq2Bx12Xgg2cGTpo5l9xMO+vNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ni28G60F; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260105170910euoutp01fad7ea02296683c3c80f729b105bb258~H5M2U4UMh1714117141euoutp01a
	for <linux-pwm@vger.kernel.org>; Mon,  5 Jan 2026 17:09:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260105170910euoutp01fad7ea02296683c3c80f729b105bb258~H5M2U4UMh1714117141euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767632950;
	bh=5xmUoTayWuvB81VRZnjQHc05KNDT+9emYL6rxIOk0sg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ni28G60Fr3Lwbsna6LOobloNS6pbLrABYKBLgXzJMDQKd2DQyO9qksMLgOlebWCsg
	 nypFx+uVms2n2Hrg/38zPNN/HH7X9gTgaaFU4dA9jwVudFA3EHWff6YP5D4QH+KY7K
	 7ipkDsAw3RLm70OOtwRfXQ4OadN1xloEE2Vj5ShA=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260105170910eucas1p2ee59b1dcea1fa67b21e6256e2da6a84e~H5M2Ezpwt2713327133eucas1p2r;
	Mon,  5 Jan 2026 17:09:10 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260105170909eusmtip2f66732762ea0c0d6a685a93ba31c08d0~H5M12jKPo2496624966eusmtip2b;
	Mon,  5 Jan 2026 17:09:09 +0000 (GMT)
Message-ID: <c56beb39-c186-49c7-9620-50ad398cc596@samsung.com>
Date: Mon, 5 Jan 2026 18:09:09 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/27] rust: pwm: add __rust_helper to helpers
To: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <20260105-define-rust-helper-v2-14-51da5f454a67@google.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260105170910eucas1p2ee59b1dcea1fa67b21e6256e2da6a84e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260105124303eucas1p194e4764812c4a861ee7cfb83bdca596d
X-EPHeader: CA
X-CMS-RootMailID: 20260105124303eucas1p194e4764812c4a861ee7cfb83bdca596d
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
	<CGME20260105124303eucas1p194e4764812c4a861ee7cfb83bdca596d@eucas1p1.samsung.com>
	<20260105-define-rust-helper-v2-14-51da5f454a67@google.com>



On 1/5/26 13:42, Alice Ryhl wrote:
> This is needed to inline these helpers into Rust code.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Cc: Michal Wilczynski <m.wilczynski@samsung.com>
> Cc: linux-pwm@vger.kernel.org
> ---
>  rust/helpers/pwm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/helpers/pwm.c b/rust/helpers/pwm.c
> index d75c588863685d3990b525bb1b84aa4bc35ac397..eb24d2ea8e748364f3e17dccbb6a92fd7f2514c0 100644
> --- a/rust/helpers/pwm.c
> +++ b/rust/helpers/pwm.c
> @@ -4,17 +4,17 @@
>  
>  #include <linux/pwm.h>
>  
> -struct device *rust_helper_pwmchip_parent(const struct pwm_chip *chip)
> +__rust_helper struct device *rust_helper_pwmchip_parent(const struct pwm_chip *chip)
>  {
>  	return pwmchip_parent(chip);
>  }
>  
> -void *rust_helper_pwmchip_get_drvdata(struct pwm_chip *chip)
> +__rust_helper void *rust_helper_pwmchip_get_drvdata(struct pwm_chip *chip)
>  {
>  	return pwmchip_get_drvdata(chip);
>  }
>  
> -void rust_helper_pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
> +__rust_helper void rust_helper_pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
>  {
>  	pwmchip_set_drvdata(chip, data);
>  }
> 

Acked-by: Michal Wilczynski <m.wilczynski@samsung.com>


