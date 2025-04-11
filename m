Return-Path: <linux-pwm+bounces-5465-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA4DA868F9
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Apr 2025 00:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB113BAD6F
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 22:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC6829DB60;
	Fri, 11 Apr 2025 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAgEwFik"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB020B7F1;
	Fri, 11 Apr 2025 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744411965; cv=none; b=OOZ6kO1N+wQLiWEcHI6bvQUJaKKjhgy8CDGg2U1yTggLfwR4iJ9tAoeSioUXVBpxC19+dPRskgEbLIgWi21GKD5lTTBuVZKJlxC01eFhwyQtZ7fG3VpxTD0E2OmlgKjgsClMwzLc67x8dImiM/uPbB8bFBeOkryCCiE6v/BnFkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744411965; c=relaxed/simple;
	bh=ATjW5hPmtzhuRMZnNpxT2hdn9PN575jnzUepPgCmueA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOTjNqRnKFzX94woIWXKa372celAaGK52+9a4xk+z1PazE48CpQwz3pSFPi6EvEFyRX4HQ+8FYcbDlsBx8PGKZgHHEBjaWJ5J/5AMmfVzRcxPE0W/Ozi4XGgCqdk2zdmQA3cg+q0O2KhaQ1nzJL1Y2G+EGDB/+ufVt6cgOjkM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAgEwFik; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f6970326so23898356d6.0;
        Fri, 11 Apr 2025 15:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744411963; x=1745016763; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pL39NwqtcbYwkvvLQB2h2yxEcQFSSiMNcOUnB8oXOc=;
        b=RAgEwFik4BZNIrbQIgE4kY6YyKNbuyCGtZh5pwyTa9n9Da91qVkIvj2ink6GeAZGvY
         fp1JjsoosajpQIa8eDLv/0Tfm26wqZ8FSXPhc4SNuz4+JaK36Wszb3jNyBsE4Dyd45jj
         Nu9CqPAUX8qNBTg4fHumP+N3ipi3uDf+BMsfdU1y6i576VTPb6oNMlXRWWKUhgs5nf4t
         2HC3pzubyOpYk3ub5gXdsbFSnpRhNNe61RLA6g8+yD1ekAdk18vxSuMXpXkTQempIvhu
         h+zOcTxyogMlKRuydpEpwpIXhrqbNjiek2wSEx7Gv4WyWFHXE5k/+GZ7WcB9mp4Hl0Jp
         zebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744411963; x=1745016763;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pL39NwqtcbYwkvvLQB2h2yxEcQFSSiMNcOUnB8oXOc=;
        b=Elvikkp7CLmKnb2DOwYjkrXFZj3IiPrhofdWTUMYbLTE4B6icul4Eh1ZE9Hb8aerUg
         +zR/WVYKmT5o/8uJg6Dq8lGwScl7JgipEuxqCeM6vN4c06UvV64mxlkFm5GX9BNfhrPk
         oazXC1HICey93Roq1Am+zzteRehpV54s9p69SFuR68yT3h2B+nfaPFsEFSRKJlTu/JdC
         G7+4EWBBVcQSI95Z7TpGAzgPZ7wV3sXVbWE79rXO0h2F1cpJwZ2pynBzk0PJQ93djL2Q
         eVYOSehlyqzQ0ZpYMbGvbVGg1AZLDLMIHyXpnuEi8B4c3IGiUe5RwGXsXx+pckKrawCA
         Y2cg==
X-Forwarded-Encrypted: i=1; AJvYcCUhD8P73dCZAgVan2kN6EQVDINrreyY/wWPIcjnQUpJIKAM5aBWet8znzqEzQWAyXltLZ3NdpQ45TXu@vger.kernel.org, AJvYcCV2rWiJR9JK7jK8ue8icK0FpsrXQ362sHG11huPa7jJtUQKcams/0EWkJU6tak5oB3UsEBYVPb3zkQG/qOu@vger.kernel.org, AJvYcCWYXd77oHzscFq+tSweSLEKllhjIjXemszYDJ0AxWeUU15ybN9anctmS6WmUqi8zlXjiNMKdAhPgWl4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0iBAdXhPlqle1oN44XR/TUDxZCzZfRtod9dAvNiXR2DBL/eRi
	2+74KFPT3SfShswwoLISA6oC9sHU/Yf6Yt8kSnQZb5tBedgs8nnl
X-Gm-Gg: ASbGnctqxEhrD1qKPicj25/MExAdc5qJQKtb+jlm2Z+Zch36yWEr6YE4S9acjFH/12B
	J3j9lwvbsg/HY8ZFdA7FiZw0rG17EDq6Ov3xf8gDs/evoD5O2JpCnIBXxIV36Asw+mU8ieQLH8s
	PYsJSHw9dNEIy/lMhq45ZypUzr22ZcDF1EBXBlhG4etacig7pfyqb6viCSwcqX+vrb53BqQ2y2V
	XUuxpp5+ZJ3LFmAOxMzFrgscW7qiUSvZz1ICE6f8RJ4tQ+/T5WhCG9NxcWqvTmpiAJBGR/dbD1S
	n6me4quO5T2DC2pG
X-Google-Smtp-Source: AGHT+IEtXcGKPfNuWYv/aDDJ2tC8l5U6EHJb2KzYLLEpb/rDKTBSVSyfh6IvpIF3Bho/Sys5i6hwmg==
X-Received: by 2002:ad4:4ea2:0:b0:6e8:fe16:4d45 with SMTP id 6a1803df08f44-6f23f16135bmr58411176d6.41.1744411962994;
        Fri, 11 Apr 2025 15:52:42 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de95fdfbsm42753596d6.1.2025.04.11.15.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 15:52:42 -0700 (PDT)
Date: Sat, 12 Apr 2025 06:52:03 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Guodong Xu <guodong@riscstar.com>, ukleinek@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dlan@gentoo.org, p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com, 
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com, 
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr
Cc: elder@riscstar.com, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Subject: Re: [PATCH 9/9] riscv: defconfig: Enable PWM support for SpacemiT K1
 SoC
Message-ID: <6fywndrxglozw2oqrfs66l3hxxsrv5uf5hdiuyv4a2uczwiiki@tmijrmuidlin>
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-10-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411131423.3802611-10-guodong@riscstar.com>

On Fri, Apr 11, 2025 at 09:14:23PM +0800, Guodong Xu wrote:
> Enable CONFIG_PWM and CONFIG_PWM_PXA in the defconfig
> to support the PWM controller used on the SpacemiT K1 SoC.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 4888529df1d8..9bd972867e0a 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -259,6 +259,8 @@ CONFIG_RPMSG_CTRL=y
>  CONFIG_RPMSG_VIRTIO=y
>  CONFIG_PM_DEVFREQ=y
>  CONFIG_IIO=y
> +CONFIG_PWM=y

> +CONFIG_PWM_PXA=y

Why not m? This can reduce the Image size.

>  CONFIG_THEAD_C900_ACLINT_SSWI=y
>  CONFIG_PHY_SUN4I_USB=m
>  CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
> -- 
> 2.43.0
> 

