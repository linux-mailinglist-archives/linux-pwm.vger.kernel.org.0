Return-Path: <linux-pwm+bounces-5459-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA869A860F7
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 16:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F15CD3A89EE
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0DE1DE896;
	Fri, 11 Apr 2025 14:45:59 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43BB157A46;
	Fri, 11 Apr 2025 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382759; cv=none; b=fjh1+/hWxg/EzDBYJa26ATvjnoWfGI2l9/6MIb5VfHrrGlJOM97WgNpkMYhSpR00z/Q2Lgh9Bd1GZMVsqptB0XOUyVTpGkIpZcpPUbIiMNAB6pP2S928zJfN3XWOtgU3DZLLEc7QQ0vWLGIzFDI+pHOD+jnVQPYqT54hrQ24O7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382759; c=relaxed/simple;
	bh=2qew7d5QYGHupMXom6yEmImq3ecfWDyQOuyLEHQb2Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkMYZYJBGT8lBgHwg9VQtlSGH9li2sF/Mi7A+UQ2vJAeNKhMDwUQUqM7Kon21v8j8hC66wh21UnEf7WMHJy6uQfa9LAnQv3fs4Iqc7+hyBmfkxqQhQtB45vlpqPkZwUGtsg2tndSllb4xhAuI2cKBIj/Aj3C3OQCDLbROQj2RTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.27.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id DC77E3436BC;
	Fri, 11 Apr 2025 14:45:55 +0000 (UTC)
Date: Fri, 11 Apr 2025 14:45:49 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: Guodong Xu <guodong@riscstar.com>, ukleinek@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com,
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de,
	hal.feng@starfivetech.com, unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 7/9] riscv: dts: spacemit: Add PWM14 backlight support
 for BPI-F3
Message-ID: <20250411144549-GYA22568@gentoo>
References: <20250411131423.3802611-1-guodong@riscstar.com>
 <20250411131423.3802611-8-guodong@riscstar.com>
 <20250411140510-GYA22364@gentoo>
 <d2c26d3e-787a-490e-9134-8ffe2f6b8333@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c26d3e-787a-490e-9134-8ffe2f6b8333@riscstar.com>

Hi Alex,

On 09:23 Fri 11 Apr     , Alex Elder wrote:
> On 4/11/25 9:05 AM, Yixun Lan wrote:
> > 
> > On 21:14 Fri 11 Apr     , Guodong Xu wrote:
> >> Add a PWM-based backlight node for the Banana Pi BPI-F3 board,
> >> using PWM14. The backlight is defined as a 'pwm-backlight' device with
> >> brightness levels and a default brightness setting. PWM14 is assigned
> >> a period length of 2000 nanoseconds.
> >>
> >> This configuration was used to verify PWM driver changes, with PWM14
> >> tested and its waveform confirmed as correct.
> >>
> >> The node status is set to "disabled", and should be enabled when the
> >> display driver is ready.
> >>
> > .. see comments below
> >> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> >> ---
> >>   .../boot/dts/spacemit/k1-bananapi-f3.dts      | 32 +++++++++++++++++++
> >>   1 file changed, 32 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> >> index 816ef1bc358e..d04b57ddeb46 100644
> >> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> >> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> >> @@ -28,6 +28,32 @@ led1 {
> >>   			default-state = "on";
> >>   		};
> >>   	};
> >> +
> >> +	pwm_bl: lcd_backlight {
> >> +		compatible = "pwm-backlight";
> >> +
> >> +		pwms = <&pwm14 2000>;
> >> +		brightness-levels = <
> >> +			0   40  40  40  40  40  40  40  40  40  40  40  40  40  40  40
> >> +			40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40
> >> +			40  40  40  40  40  40  40  40  40  41  42  43  44  45  46  47
> >> +			48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63
> >> +			64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79
> >> +			80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95
> >> +			96  97  98  99  100 101 102 103 104 105 106 107 108 109 110 111
> >> +			112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
> >> +			128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143
> >> +			144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159
> >> +			160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175
> >> +			176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
> >> +			192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207
> >> +			208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223
> >> +			224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239
> >> +			240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255
> >> +		>;
> >> +		default-brightness-level = <100>;
> >> +		status = "disabled";
> > I'm confused, has DT in board file with disabled status doesn't make sense?
> > it doesn't really useful for placeholder, even worse that functionality may not
> > verified, so I'd suggest sending along with display driver while at it..
> 
> I think I suggested he include this.  Guodong tested PWM using
> a backlight on a display connected to a Banana Pi PBI-F3 board.
> The above numbers come directly from the downstream code, which
> uses this PWM consistently as a display back light.
> 
> But you're right, the exact set of numbers to use is dependent
> on the display used, so it's better to add them when the display
> gets integrated.
> 
Ok
> The pwm14 node could update still be added here, but that too
> might as well wait until there's something to use it.  So I
> think this patch can just be dropped.
> 
thanks for the explanation

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

