Return-Path: <linux-pwm+bounces-5467-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEEDA86926
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Apr 2025 01:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D75188FE73
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Apr 2025 23:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE212BE7A5;
	Fri, 11 Apr 2025 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fj/QHMnP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A729DB7B;
	Fri, 11 Apr 2025 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414131; cv=none; b=ddt5fX7LPRdsCVic2DhEKF+0jiYhSXM4aHTkSGZDRx9Ib8DNBTS7ZeMD91zOqYwHK9jOnVOlIXDV5KLZ9ncnSq4xzD+Q96EMgQEGKmckyklksVhXbRHVWN6EZSg2Sodmsbqw8aUjd7XdnUvz5ek0wzBUY8e86IeyiJ9dhEGGGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414131; c=relaxed/simple;
	bh=dSvC1EEFJ0pyt4oMgiDtpsgtB3ByVDFhaXNFrpFOr2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbB7fRb80NbWuXCrg5PZ2CvJHhybCyvFIZ0m8W4JZ0Z5cjkpDbx2GL5Ysu4b79mcjbDONEMsBi1128AR9MK8Acc4xInOt6Q03DyAoFDOXDyd80ADQrCdwSUmMwyxB0lHOpiNl82eZBFj+6CCy6mOelZXWwOvY08zjl9AwaGpHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fj/QHMnP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476ae781d21so24401071cf.3;
        Fri, 11 Apr 2025 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744414127; x=1745018927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvhHzpdybge7k/1xu+C8wVpLlcBQbPdkbGL/bYzd4aw=;
        b=Fj/QHMnPSKpxdAKGYSxvUfr3+if3NuUNgYIYO7T2WGHrRvGLFKKtPvEJETwZhOOg/M
         zFCzhhOe9+W8GeHF9/hqtayGiTt7D1GbBLwvZXX09xZ6zV9ublCGOSHA21eyiygZbTP0
         CnLIrVflgnjy4VL4y7nWLSCy8WgnI+r1GnyYpddVBt1eLici9lGF/VXaoLfsSTYuPqBe
         pkZH9M7CljTD4uTTuqz5Z0uuS5T/20VuH/nOgm85xPFBv4PBhlwHSyXJAwwZZRUFm2Yf
         aQwBAH1Ke4MRxXy9jxUir//gVw8rMu1eGC4rIKH8PlpNC27+RRaAk2LSbnU8sev5WfHJ
         NnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744414127; x=1745018927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvhHzpdybge7k/1xu+C8wVpLlcBQbPdkbGL/bYzd4aw=;
        b=TmwwV23BMoGr/FFuCdQEM2s15owNS0WTJ529XZVl8VdKb/zgH4SgBZs1ZsO8Y0XV4a
         uJBVDlltF7XI+aXIxWvpdg+EjWOjdSwVeb5DyEJVtgts8dxaZsFuGHtbzgDZyGCxGVI1
         h4Ee0sQW9mmCJCIp5x1s+yvkD7jc+80LwtSTbrM6cOEdgRAZ4xVPFb/E8xOEQRrdvcUp
         b3vqSfNfaWtiHMpwW+ASQonUbO+S+JPZx7TRIL3v6FmsNSlkAujUXB95bQDfYEfG04mf
         bbqcrRJ977Bs2Ap66gAJSx3IYLJXVE4eW14KyumJe8Fhv+SDQe3Lo3YNxi6RZzXuVhpJ
         z1Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVYltkDE16vdJfCFZxv8MPsfcpf/UMeXqNyxsEZtda0P3R01rVZGRKUWrCzCy7lDu4mbVfxxiZruG26@vger.kernel.org, AJvYcCWzBdA0JJtAiZL/65o//BNlulMx/HuCNNUYYC/ihPDtS6iOIb7uiCr3S7e+QUdYcYqcuGGP6nTvKTHagUVL@vger.kernel.org, AJvYcCXU0NpvSXrfZ+7tiVvlq491rYM/XK4bhOf78ZqVQRGKpTfpkNP32AY6xgmduP2zx44aYK7OIrs6f2U8@vger.kernel.org
X-Gm-Message-State: AOJu0YyOvMyEnQ86KHoc8DNOc+gCwnGJlPlsBDLDV6AMqADF2fY40U/d
	ScphBSjB8UNjH3e93MzK9nOGxhrx7oIqCsWQIRE2atN7PJV33co2
X-Gm-Gg: ASbGncskkyyl+LAYCLvMqg0oWm9KDIx2n6Nw68lA7xw2xu3x8pkgTICchqXIqzgXRBY
	CttZYobeI4E5sUeXKgXjJdq/AgtcV3awt70QP87QqnyRMOPT8WNxa6f6E4J4ffoEM1PrrevIpvD
	WMXlz8atknUh5R1SlR5EL14j2rnD8vt7cdYS2rN1OOasP0jPRwYnFpiKR4xr7OPpprifAUNot1J
	YW8GvPFGGHviHB78KKoFkB8lXjJzjhBxaDxQ1LtHgC3tiOxrN6vw7Xjgyeo0XvNoDCtbaA+VfGo
	hSEU90A2O3AfkB7FMvcBirwloBg=
X-Google-Smtp-Source: AGHT+IEULaHSVU7/79T4sGgtSLDudJBk/aXEwPTYZC6UzLhe6HrogH+KkmZ3Al7QHscxwG8JxOb5sg==
X-Received: by 2002:ac8:5fd6:0:b0:476:980c:10a8 with SMTP id d75a77b69052e-4797752ddf6mr68207601cf.21.1744414126840;
        Fri, 11 Apr 2025 16:28:46 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796ed9bcdcsm33442711cf.49.2025.04.11.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 16:28:46 -0700 (PDT)
Date: Sat, 12 Apr 2025 07:28:07 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Alex Elder <elder@riscstar.com>, Yixun Lan <dlan@gentoo.org>, 
	Guodong Xu <guodong@riscstar.com>
Cc: ukleinek@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de, drew@pdp7.com, 
	inochiama@gmail.com, geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, 
	hal.feng@starfivetech.com, unicorn_wang@outlook.com, duje.mihanovic@skole.hr, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH 7/9] riscv: dts: spacemit: Add PWM14 backlight support
 for BPI-F3
Message-ID: <j35vjluiykbu2gxg5zkoxm67muj5y66zn6tjwhdbnolkyeilh7@cubjbzouewiy>
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

On Fri, Apr 11, 2025 at 09:23:29AM -0500, Alex Elder wrote:
> On 4/11/25 9:05 AM, Yixun Lan wrote:
> > 
> > On 21:14 Fri 11 Apr     , Guodong Xu wrote:
> > > Add a PWM-based backlight node for the Banana Pi BPI-F3 board,
> > > using PWM14. The backlight is defined as a 'pwm-backlight' device with
> > > brightness levels and a default brightness setting. PWM14 is assigned
> > > a period length of 2000 nanoseconds.
> > > 
> > > This configuration was used to verify PWM driver changes, with PWM14
> > > tested and its waveform confirmed as correct.
> > > 
> > > The node status is set to "disabled", and should be enabled when the
> > > display driver is ready.
> > > 
> > .. see comments below
> > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > ---
> > >   .../boot/dts/spacemit/k1-bananapi-f3.dts      | 32 +++++++++++++++++++
> > >   1 file changed, 32 insertions(+)
> > > 
> > > diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > index 816ef1bc358e..d04b57ddeb46 100644
> > > --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> > > @@ -28,6 +28,32 @@ led1 {
> > >   			default-state = "on";
> > >   		};
> > >   	};
> > > +
> > > +	pwm_bl: lcd_backlight {
> > > +		compatible = "pwm-backlight";
> > > +
> > > +		pwms = <&pwm14 2000>;
> > > +		brightness-levels = <
> > > +			0   40  40  40  40  40  40  40  40  40  40  40  40  40  40  40
> > > +			40  40  40  40  40  40  40  40  40  40  40  40  40  40  40  40
> > > +			40  40  40  40  40  40  40  40  40  41  42  43  44  45  46  47
> > > +			48  49  50  51  52  53  54  55  56  57  58  59  60  61  62  63
> > > +			64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79
> > > +			80  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95
> > > +			96  97  98  99  100 101 102 103 104 105 106 107 108 109 110 111
> > > +			112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127
> > > +			128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143
> > > +			144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159
> > > +			160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175
> > > +			176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
> > > +			192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207
> > > +			208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223
> > > +			224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239
> > > +			240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255
> > > +		>;
> > > +		default-brightness-level = <100>;
> > > +		status = "disabled";
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
> The pwm14 node could update still be added here, but that too
> might as well wait until there's something to use it.  So I
> think this patch can just be dropped.
> 

If this patch will be applied as it is after applying the display
driver. I recommend to preserve this patch, but move out of this
series and resend it as RFC. If this is only for test purpose, it
is better to move this into the cover letter and address it is for
testing. 

In most case, patches with some unmeet dependency should follow
maintainer's request, or has specific purposes. It also needed to
be marked as RFC.

Regards,
Inochi


