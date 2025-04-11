Return-Path: <linux-pwm+bounces-5457-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B9EA85FFC
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 16:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785483AD677
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 14:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1B81F180E;
	Fri, 11 Apr 2025 14:05:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59148635A;
	Fri, 11 Apr 2025 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380319; cv=none; b=Thj4Rw6KBLIc/sNoxUYfDfpMOiRCPX1pbSu0N+hJLq+gNRqFtW3VHQOf7E98n+03071h7ke0vquV6Kdx/WLTZBbSLJtA+mgmFbp3SX3GoEmAMFJdsV0AsgNtRVJ6HMAbwMeLtT3yMLWQCRsbADcO11gwxP/Ts5HmzP6CuzNGtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380319; c=relaxed/simple;
	bh=WWH7pjgLhq7CdCx4NdmHmV8ilE+5LHo+30ZTrkElue8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npFI8Iz0BXhC0r7sQ7EE3JEv/mdMJxXdOAARitJrZ/bzovwTZlOy7LJwlPnCznNKC7cd5/JcUd+Rmc/H0nPX2dJKK2QL4EughQxEkKxqbF8JMC1bg80+FGSk3ow1uOS9RXxqsdIdpvvaFkiyPcWVYcSvQ6oGbnXr6gTmEy5+BJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.27.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 901F03433FD;
	Fri, 11 Apr 2025 14:05:15 +0000 (UTC)
Date: Fri, 11 Apr 2025 14:05:10 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	drew@pdp7.com, inochiama@gmail.com, geert+renesas@glider.be,
	heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com,
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr,
	elder@riscstar.com, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 7/9] riscv: dts: spacemit: Add PWM14 backlight support
 for BPI-F3
Message-ID: <20250411140510-GYA22364@gentoo>
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


On 21:14 Fri 11 Apr     , Guodong Xu wrote:
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
.. see comments below
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
> +		default-brightness-level = <100>;
> +		status = "disabled";
I'm confused, has DT in board file with disabled status doesn't make sense?
it doesn't really useful for placeholder, even worse that functionality may not
verified, so I'd suggest sending along with display driver while at it..

> +	};
>  };
>  
>  &uart0 {
> @@ -35,3 +61,9 @@ &uart0 {
>  	pinctrl-0 = <&uart0_2_cfg>;
>  	status = "okay";
>  };
> +
> +&pwm14 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm14_1_cfg>;
..
> +	status = "disabled";
ditto

> +};
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

