Return-Path: <linux-pwm+bounces-5466-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61258A868FF
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Apr 2025 00:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AFA8189C364
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 22:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D129DB91;
	Fri, 11 Apr 2025 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrHwYLeR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF429CB3D;
	Fri, 11 Apr 2025 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744412139; cv=none; b=gD8uBfbs5EkX9KN3IChW+zcMmEWFenrwutVGkmN2egP6DPKO58Mn1tuK9YVseFXu1bN5541RAQztBxrZKS90LcGomv9vqwG9dHuzPG83YqvUDT8vugozbq3Nkwdw8syFP68f+IZcx617a8ECW0X7T1+fw1JRF6Osazrj4t9ASZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744412139; c=relaxed/simple;
	bh=GMrDL5pQoDGhmVPfvwpSJ4KisP7dbK9ERODVtgcG88Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWtMD+WxQp0aEEqcqYGOZ7JrjvEKS2qQhy+NTaLYjvFRoSBMCXAlubKh20ceP18wsT4hn6x1MeQE2BUIca3Dzvyh6B516lgSvcWhpDnPiGFNno2xg8wLmdAlzGfYL0uzfoYUAxGrCBv3wzFOfG2rpF2ChwKfypzLhq1TdO+VwTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrHwYLeR; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c5568355ffso210784485a.0;
        Fri, 11 Apr 2025 15:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744412137; x=1745016937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BsvfhzOprEtaLfmXELk368lBC6dzFrOtz5GX2QaLNAI=;
        b=lrHwYLeRqQoLJnT3Fe7Dshek125X0k0FbdJ2asp3gP1CN7+98XbLCMv0YaQUs0er6X
         YnTWKM6HXKKXBw667TMFXZhO5a7ibIkInuVj+KfzeHhzBsvixwhLvEcAJmF6m+mcgLhm
         FSbaSh6tRyAqSf67qfqnkf3GvgUmKldrP85aWA65OcRzbCXnyl2YhO2n9G01NmYwz4MJ
         DK/nvR9WYVb0qRj9m3RobjlyzOGejs3qasJom0nq4IQ+d/kLGLmE+jzzIW0FB5xo7e9l
         2GasVKLaXQCt1G9nXMTkjWD51vVNhAwx8mLPuUblaHr0Of25gDdIHbI3IWLE69FbbBYs
         MdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744412137; x=1745016937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsvfhzOprEtaLfmXELk368lBC6dzFrOtz5GX2QaLNAI=;
        b=QrhYfLxefWwQltCZIsgCEHILYzIPKro3SIM7tNvcs5GX7fozuTmX6n94qna8+Ov+kI
         /Pca09a8NvzwFh4jKX7bAaWqaqHr0WucLB2wFsAz9gaO9Hob6zwwbrduyWMhqoabzWca
         yEcYcIdx93kpSMJusyQQgVNp5UJS3SI34jrixposRwq8SYPtPXuoDpwod/s/SW1uwAA4
         mFxaRuP3PppK+Q8Nannz3J+LW+wjrJh/jxgCoV1IJ+uwODMvuivRyv5aMoiZEIUETk9r
         FRGmSnAcQ2+kyGfn0qQHXsZb6FkCRhJCsqak7UeV98UsnDNcM32n1Q9zF9wsuihcYtuY
         WsvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw4rQ2Aelycp/MtnUu9/5s80ZL1n98xOGfoSfe3mqr/IzWm7DOcs7x7Qn448GNUmAwuW3oMIhLPbQ9@vger.kernel.org, AJvYcCWPoN1+efKQ1sGKRzW7dPnXSuCliNv21xrsEmGiPcV5eNK1OBCqgmbFmlBl8280r/dmpL9aG0eyRtTbrAK+@vger.kernel.org, AJvYcCWXlwtmiQnOY1VXV65RjhlJX2VD73aI2uwXRlY5KpfdNPhW1u6jPyGGAe/wp8BDhapha6FdZfBzBzDH@vger.kernel.org
X-Gm-Message-State: AOJu0YySWvuy/Kl2QO4BsN78UId45FOqTdp/8WhxC2SrZPn52NPsFGVZ
	1vCiZje+lUfIAaU9ZG14Bz5aFwhJ7qTTlSkE6q8zc05RqBiXYpNd
X-Gm-Gg: ASbGncvVR6HZp35H+ZtzcFfRVeZH+AwiMA2WWDq+wRcfryVJPuIYCucPFPKodFyCCMF
	B8ZDR7mPF5fmQB9pEtl/uOMlQLFtviYZSQIkZLQqFw8oQOl9wbBakOj4lhoETOWfikl3FWEcFYu
	cgJ1Wrj98H2rpGHOmbjblc+K2cTP5oFb9zi+GX7ATB+Tut/DnsJhJvq7UNCEge2ucTKH9DTg5hP
	GABkZlHOOUtbT1xkWtX9TNb923Y3fIA/z3S9qv1ZDWzR4Adyp+o4VogUkv2YDYWsnBKlSs8/bih
	yKLxMWuu84y0EcD5
X-Google-Smtp-Source: AGHT+IE1/vXomAHPxMpa48ltkrdDHc/3oW7KILrsJLrC6iJGPLluuSppvCXu45uAv9myLPwVn1XuLQ==
X-Received: by 2002:a05:620a:4148:b0:7c7:a1c4:86e2 with SMTP id af79cd13be357-7c7af0c0fbemr711017585a.11.1744412136857;
        Fri, 11 Apr 2025 15:55:36 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8943bd5sm325345885a.14.2025.04.11.15.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 15:55:36 -0700 (PDT)
Date: Sat, 12 Apr 2025 06:54:57 +0800
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
Subject: Re: [PATCH 7/9] riscv: dts: spacemit: Add PWM14 backlight support
 for BPI-F3
Message-ID: <cwbbq6pubksgpbloqdxspn7sr7tanbjdnbdobctayblpkahukp@zxypidw7a6un>
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-8-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411131423.3802611-8-guodong@riscstar.com>

On Fri, Apr 11, 2025 at 09:14:21PM +0800, Guodong Xu wrote:
> Add a PWM-based backlight node for the Banana Pi BPI-F3 board,
> using PWM14. The backlight is defined as a 'pwm-backlight' device with
> brightness levels and a default brightness setting. PWM14 is assigned
> a period length of 2000 nanoseconds.
> 
> This configuration was used to verify PWM driver changes, with PWM14
> tested and its waveform confirmed as correct.
> 
> The node status is set to "disabled", and should be enabled when the
> display driver is ready.
> 
> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> ---
>  .../boot/dts/spacemit/k1-bananapi-f3.dts      | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index 816ef1bc358e..d04b57ddeb46 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -28,6 +28,32 @@ led1 {
>  			default-state = "on";
>  		};
>  	};
> +
> +	pwm_bl: lcd_backlight {
> +		compatible = "pwm-backlight";
> +
> +		pwms = <&pwm14 2000>;

> +		brightness-levels = <
> +			0   40  40  40  40  40  40  40  40  40  40  40  40  40  40  40
> +			40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40
> +			40  40  40  40  40  40  40  40  40  41  42  43  44  45  46  47
> +			48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63
> +			64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79
> +			80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95
> +			96  97  98  99  100 101 102 103 104 105 106 107 108 109 110 111
> +			112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
> +			128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143
> +			144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159
> +			160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175
> +			176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
> +			192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207
> +			208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223
> +			224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239
> +			240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255
> +		>;

Can we simplify this level matrix? I see it is continous in most cases.

Regards,
Inochi

