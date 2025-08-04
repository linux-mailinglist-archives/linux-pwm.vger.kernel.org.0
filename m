Return-Path: <linux-pwm+bounces-6951-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28052B1A301
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 15:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E65C18937A0
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB082459F3;
	Mon,  4 Aug 2025 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gtH5Hx5N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04C3242D6C
	for <linux-pwm@vger.kernel.org>; Mon,  4 Aug 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313262; cv=none; b=qQjzubM2z/TohG7E1EL0ltYrFfwzCHaUfoVnPQ7x7IrQPDNEKdd3DoT/eAO9nGvT4M8NFG8GviAnemvDYy9dfdsqZxmbroIE9FOdBEUYTHdiAy8qnxgU+72vO9DIpljiWvBKRVLCQ1iMF6w1p47xOPJ3CzgdpHfqLLXJpRHyb0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313262; c=relaxed/simple;
	bh=uu55DXgtt1m2iyU3Bb5oHk+msNnCK0nIu/P21JA12cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g190CG5fNOtYOPsK7k4y5+C0RKvgeJ6uaDJ6c0tf69J1egEQ3kmTUphuuy2SRHKg56+WYnPQC60twbG+R85csjg6Fj0fXTTX0gldft2BnWrbt4V8nSn55n9jcvJu6MvRlUihtqD0FaT8phEmXtuu96eI5wm00ar9pD4ckv2thYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gtH5Hx5N; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b788feab29so2326931f8f.2
        for <linux-pwm@vger.kernel.org>; Mon, 04 Aug 2025 06:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754313257; x=1754918057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O5z665d7ULd43whPiXaAaYwiZPV604txXYt7r582gyw=;
        b=gtH5Hx5NijyhExB1f7iyNwikpmhGvXCMSfIU8g1PncXX0VaqTWbK55I4QX7JbpxGFr
         s7fvA8u1luZQO4050DeM67nynfvlf1x2U4cXZ15lJo+qUObsSlgYQdr1yITBB/OghGjk
         8+RhX7cwIJbTqsDB2aiiSohoxRE+6D7vwvk99l7GaAG2/4sMBh9e8ASkPLnxcwg2/rXs
         h4LFOIkXHJz8oow35Q1/3+ZC5bAcOpwHXm3wgvdjA40xQeKUaBz4ploh3sKsoon7/UlA
         7IUQ6jW2rV//4mO3qN6vl8KF3ijX6ycp2/zwygItdmfR7cdAFqjfnlEdqIocFG3J8sur
         1wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754313257; x=1754918057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5z665d7ULd43whPiXaAaYwiZPV604txXYt7r582gyw=;
        b=U5YwEItjsNSLakcQiikauuko+mhuYg2dif/tnDEYybOjeSEMs9tArV42N4MH9w4OID
         YFo8dN+k6LmWlMI7UfhYGJRLL6GjtgnzxcmBZouf8cB1ZmKPgijdKYC+G/DjPPnGk728
         J2u4PyCHsLdhiHBrepL+9viYaqRyeyibU3ziIOCF098BMs9NErN97gIw5p4NnYhLx9T0
         uDX09p+BKKlbuC5eWnXDkiUxUGPypyY4mUJ8tLSBZyOE4Qfv5KAPYPoYMEKpLLv+lWa7
         T/2VogYnqkqImv0jjCPJ5RZwJ373a8r+92Sr7eIWN0aeNIL4fZKbmrzYCTi2wlF3gSj4
         yCGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmEuP5exhjLCQu/jh/uckrXeabk25LFM5lfLXOUpkNNMR7c00R8klbfSLYYMg9BcjxzjOpACfvKbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQZH9IaZvyYmoz/RLB51zE2ZVYcUw/tciuDPfXn1Z1QlSUS6P/
	NRYBFzMktoff3c+MS/hMuMYdhgz1Drjg8iAPUt4iJAjcA7QeB4/53RmUNMCn5968LIcNKgEkg5a
	rLyVe
X-Gm-Gg: ASbGnctuF2v63gorvdmdxLeGPqZ7iQ6c8vZkqfGs45gMqKQWQ7H6TIHmP5FzYwD8sFI
	dJEMAAxcb1GRW3cyIL6BPGPjHjTP8wdOHui9D/GSCgHWKnk1QFe3Iv481AiviefFQLpyWUcViEl
	HRAikcpHbZMuxDp2ybYdcGoBEFawg4q9Gwj0As+EBZZ5jJx3u5WE7s3vvmtU4TK0dVixCv/RJrf
	WQTbJs2P0XBarOSZ5Kv43A6nqKdIWogMtnIOEk8DAmil4lIA4o5bygkL3WzJwLI5HzYO2k0PkfD
	LtIFxBd00cJ07PsrAPJRyEOQcuLZE00Hli+gAkMZFYGqpdET86/LznpMocn6drshEVaW2JeCiOQ
	K2SE1D0Y3mzBoAK31F3Aeou6rodhKehfIhyNRjdxA+hzJznS0VFrBOPOh+UjA9LT8
X-Google-Smtp-Source: AGHT+IFGBSFH04wTKs3VT00hlwsj4lQLGS9nZwv9teVWJYIP3DZgwC7WU4Vo/i6UgQoIBOTG3UlchQ==
X-Received: by 2002:a5d:5f8b:0:b0:3b8:d4ad:6ae8 with SMTP id ffacd0b85a97d-3b8d94c9d0bmr5521600f8f.50.1754313256812;
        Mon, 04 Aug 2025 06:14:16 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45895377708sm204872295e9.8.2025.08.04.06.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 06:14:16 -0700 (PDT)
Date: Mon, 4 Aug 2025 15:14:14 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/8] pwm: mediatek: Simplify representation of channel
 offsets
Message-ID: <fpgfnzx57qzr5jxfl7g7kwtjodw5pvpjz3z42fft5p6rtyzbro@hjgavja6numh>
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
 <20250725154506.2610172-11-u.kleine-koenig@baylibre.com>
 <e3495f99-4a78-4910-9b67-6c25dfe7f989@collabora.com>
 <g4qrehzi44mgvmy76wnrhabmin454wwrngubvvikgjv3w5udl7@wmxrly3mxoiu>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4bimetohzlxl6fm2"
Content-Disposition: inline
In-Reply-To: <g4qrehzi44mgvmy76wnrhabmin454wwrngubvvikgjv3w5udl7@wmxrly3mxoiu>


--4bimetohzlxl6fm2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/8] pwm: mediatek: Simplify representation of channel
 offsets
MIME-Version: 1.0

On Mon, Aug 04, 2025 at 12:30:45PM +0200, Uwe Kleine-K=F6nig wrote:
> Hallo AngeloGioacchino,
>=20
> On Mon, Aug 04, 2025 at 10:50:01AM +0200, AngeloGioacchino Del Regno wrot=
e:
> > Il 25/07/25 17:45, Uwe Kleine-K=F6nig ha scritto:
> > > The general register layout contains some per-chip registers starting=
 at
> > > offset 0 and then at a higher address there are n nearly identical and
> > > equidistant blocks for the registers of the n channels.
> > >=20
> > > This allows to represent the offsets of per-channel registers as $bas=
e +
> > > i * $width instead of listing all (or too many) offsets explicitly in=
 an
> > > array. So for a small additional effort in pwm_mediatek_writel() the
> > > three arrays with the channel offsets can be dropped.
> > >=20
> > > The size changes according to bloat-o-meter are:
> > >=20
> > > 	add/remove: 0/3 grow/shrink: 1/0 up/down: 12/-96 (-84)
> > > 	Function                                     old     new   delta
> > > 	pwm_mediatek_apply                           696     708     +12
> > > 	mtk_pwm_reg_offset_v3                         32       -     -32
> > > 	mtk_pwm_reg_offset_v2                         32       -     -32
> > > 	mtk_pwm_reg_offset_v1                         32       -     -32
> > > 	Total: Before=3D5347, After=3D5263, chg -1.57%
> > >=20
> > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> >=20
> > What if we do, instead...
> >=20
> > struct pwm_mediatek_regs {
> > 	u16 pwm_ck_26m_sel_reg;
> > 	u16 chan_base;
> > 	u16 chan_width;
> > };
> >=20
> > struct pwm_mediatek_regs pwm_v1_reg_data =3D {
> > 	.pwm_ck_26m_sel_reg =3D PWM_CK_26M_SEL,
> > 	.chan_base =3D 0x10,
> > 	.chan_width =3D 0x40,
> > };
> >=20
> > static const struct pwm_mediatek_of_data mt7986_pwm_data =3D {
> > 	....
> > 	.reg_data =3D &pwm_v1_reg_data,
> > };
> >=20
> > ...that should reduce the bloat even more :-)
>=20
> Having the three u16 directly in pwm_mediatek_of_data is cheaper because
> .reg_data is a pointer and so 64 bits wide (on arm64) and so bigger than
> 3xu16. Also having the data directly in pwm_mediatek_of_data saves one
> indirection and so it should also be slightly faster.

I took the time to complete your patch suggestion and the bloat-o-meter
output is:

add/remove: 4/3 grow/shrink: 1/0 up/down: 56/-96 (-40)
Function                                     old     new   delta
pwm_mediatek_apply                           776     808     +32
pwm_mediatek_v3_26m_reg_data                   -       6      +6
pwm_mediatek_v2_reg_data                       -       6      +6
pwm_mediatek_v1_reg_data                       -       6      +6
pwm_mediatek_v1_26m_reg_data                   -       6      +6
mtk_pwm_reg_offset_v3                         32       -     -32
mtk_pwm_reg_offset_v2                         32       -     -32
mtk_pwm_reg_offset_v1                         32       -     -32
Total: Before=3D5427, After=3D5387, chg -0.74%

See below for the complete patch for reference.

I tend to stick to my variant, also because then all info is in a single
struct which is nice for both the human reader and the generated code
(only on indirection).

Best regards
Uwe

---->8----
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index e4b595fc5a5e..ae8fa561ce2c 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -34,11 +34,38 @@
=20
 #define PWM_CLK_DIV_MAX		7
=20
+struct pwm_mediatek_regs {
+	u16 pwm_ck_26m_sel_reg;
+	u16 chan_base;
+	u16 chan_width;
+};
+
+struct pwm_mediatek_regs pwm_mediatek_v1_reg_data =3D {
+        .chan_base =3D 0x10,
+        .chan_width =3D 0x40,
+};
+
+struct pwm_mediatek_regs pwm_mediatek_v1_26m_reg_data =3D {
+        .pwm_ck_26m_sel_reg =3D PWM_CK_26M_SEL,
+        .chan_base =3D 0x10,
+        .chan_width =3D 0x40,
+};
+
+struct pwm_mediatek_regs pwm_mediatek_v2_reg_data =3D {
+        .chan_base =3D 0x80,
+        .chan_width =3D 0x40,
+};
+
+struct pwm_mediatek_regs pwm_mediatek_v3_26m_reg_data =3D {
+        .pwm_ck_26m_sel_reg =3D PWM_CK_26M_SEL_V3,
+        .chan_base =3D 0x100,
+        .chan_width =3D 0x100,
+};
+
 struct pwm_mediatek_of_data {
 	unsigned int num_pwms;
 	bool pwm45_fixup;
-	u16 pwm_ck_26m_sel_reg;
-	const unsigned int *reg_offset;
+	const struct pwm_mediatek_regs *reg_data;
 };
=20
 /**
@@ -57,19 +84,6 @@ struct pwm_mediatek_chip {
 	const struct pwm_mediatek_of_data *soc;
 };
=20
-static const unsigned int mtk_pwm_reg_offset_v1[] =3D {
-	0x0010, 0x0050, 0x0090, 0x00d0, 0x0110, 0x0150, 0x0190, 0x0220
-};
-
-static const unsigned int mtk_pwm_reg_offset_v2[] =3D {
-	0x0080, 0x00c0, 0x0100, 0x0140, 0x0180, 0x01c0, 0x0200, 0x0240
-};
-
-/* PWM IP Version 3.0.2 */
-static const unsigned int mtk_pwm_reg_offset_v3[] =3D {
-	0x0100, 0x0200, 0x0300, 0x0400, 0x0500, 0x0600, 0x0700, 0x0800
-};
-
 static inline struct pwm_mediatek_chip *
 to_pwm_mediatek_chip(struct pwm_chip *chip)
 {
@@ -118,7 +132,7 @@ static inline void pwm_mediatek_writel(struct pwm_media=
tek_chip *chip,
 				       unsigned int num, unsigned int offset,
 				       u32 value)
 {
-	writel(value, chip->regs + chip->soc->reg_offset[num] + offset);
+	writel(value, chip->regs + chip->soc->reg_data->chan_base + num * chip->s=
oc->reg_data->chan_width + offset);
 }
=20
 static void pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *=
pwm)
@@ -162,8 +176,8 @@ static int pwm_mediatek_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
 	}
=20
 	/* Make sure we use the bus clock and not the 26MHz clock */
-	if (pc->soc->pwm_ck_26m_sel_reg)
-		writel(0, pc->regs + pc->soc->pwm_ck_26m_sel_reg);
+	if (pc->soc->reg_data->pwm_ck_26m_sel_reg)
+		writel(0, pc->regs + pc->soc->reg_data->pwm_ck_26m_sel_reg);
=20
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution =3D (u64)NSEC_PER_SEC * 1000;
@@ -303,86 +317,79 @@ static int pwm_mediatek_probe(struct platform_device =
*pdev)
 static const struct pwm_mediatek_of_data mt2712_pwm_data =3D {
 	.num_pwms =3D 8,
 	.pwm45_fixup =3D false,
-	.reg_offset =3D mtk_pwm_reg_offset_v1,
+	.reg_data =3D &pwm_mediatek_v1_reg_data,
 };
=20
 static const struct pwm_mediatek_of_data mt6795_pwm_data =3D {
 	.num_pwms =3D 7,
 	.pwm45_fixup =3D false,
-	.reg_offset =3D mtk_pwm_reg_offset_v1,
+	.reg_data =3D &pwm_mediatek_v1_reg_data,
 };
=20
 static const struct pwm_mediatek_of_data mt7622_pwm_data =3D {
 	.num_pwms =3D 6,
 	.pwm45_fixup =3D false,
-	.pwm_ck_26m_sel_reg =3D PWM_CK_26M_SEL,
-	.reg_offset =3D mtk_pwm_reg_offset_v1,
+	.reg_data =3D &pwm_mediatek_v1_26m_reg_data,
 };
=20
 static const struct pwm_mediatek_of_data mt7623_pwm_data =3D {
 	.num_pwms =3D 5,
 	.pwm45_fixup =3D true,
-	.reg_offset =3D mtk_pwm_reg_offset_v1,
+	.reg_data =3D &pwm_mediatek_v1_reg_data,
 };
=20
 static const struct pwm_mediatek_of_data mt7628_pwm_data =3D {
 	.num_pwms =3D 4,
 	.pwm45_fixup =3D true,
-	.reg_offset =3D mtk_pwm_reg_offset_v1,
+	.reg_data =3D &pwm_mediatek_v1_reg_data,
 };
=20
 static const struct pwm_mediatek_of_data mt7629_pwm_data =3D {
 	.num_pwms =3D 1,
 	.pwm45_fixup =3D false,
-	.reg_offset =3D mtk_pwm_reg_offset_v1,
+	.reg_data =3D &pwm_mediatek_v1_reg_data,
 };
=20
 static const struct pwm_mediatek_of_data mt7981_pwm_data =3D {
 	.num_pwms =3D 3,
 	.pwm45_fixup =3D false,
-	.pwm_ck_26m_sel_reg =3D PWM_CK_26M_SEL,
-	.reg_offset =3D mtk_pwm_reg_offset_v2,
+	.reg_data =3D &pwm_mediatek_v1_26m_reg_data,
 };
=20
 static const struct pwm_mediatek_of_data mt7986_pwm_data =3D {
 	.num_pwms =3D 2,
 	.pwm45_fixup =3D false,
-	.pwm_ck_26m_sel_reg =3D PWM_CK_26M_SEL,
-	.reg_offset =3D mtk_pwm_reg_offset_v1,
+	.reg_data =3D &pwm_mediatek_v1_26m_reg_data,
 };
=20
 static const struct pwm_mediatek_of_data mt7988_pwm_data =3D {
 	.num_pwms =3D 8,
 	.pwm45_fixup =3D false,
-	.reg_offset =3D mtk_pwm_reg_offset_v2,
+	.reg_data =3D &pwm_mediatek_v2_reg_data,
 };
=20
 static const struct pwm_mediatek_of_data mt8183_pwm_data =3D {
 	.num_pwms =3D 4,
 	.pwm45_fixup =3D false,
-	.pwm_ck_26m_sel_reg =3D PWM_CK_26M_SEL,
-	.reg_offset =3D mtk_pwm_reg_offset_v1,
+	.reg_data =3D &pwm_mediatek_v1_26m_reg_data,
 };
=20
 static const struct pwm_mediatek_of_data mt8365_pwm_data =3D {
 	.num_pwms =3D 3,
 	.pwm45_fixup =3D false,
-	.pwm_ck_26m_sel_reg =3D PWM_CK_26M_SEL,
-	.reg_offset =3D mtk_pwm_reg_offset_v1,
+	.reg_data =3D &pwm_mediatek_v1_26m_reg_data,
 };
=20
 static const struct pwm_mediatek_of_data mt8516_pwm_data =3D {
 	.num_pwms =3D 5,
 	.pwm45_fixup =3D false,
-	.pwm_ck_26m_sel_reg =3D PWM_CK_26M_SEL,
-	.reg_offset =3D mtk_pwm_reg_offset_v1,
+	.reg_data =3D &pwm_mediatek_v1_26m_reg_data,
 };
=20
 static const struct pwm_mediatek_of_data mt6991_pwm_data =3D {
 	.num_pwms =3D 4,
 	.pwm45_fixup =3D false,
-	.pwm_ck_26m_sel_reg =3D PWM_CK_26M_SEL_V3,
-	.reg_offset =3D mtk_pwm_reg_offset_v3,
+	.reg_data =3D &pwm_mediatek_v3_26m_reg_data,
 };
=20
 static const struct of_device_id pwm_mediatek_of_match[] =3D {

--4bimetohzlxl6fm2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiQsiMACgkQj4D7WH0S
/k7B6wf/W8Xkd+lg6Ku9HwlkEvcsnzcnunBcY0ZlpFUKSwUGGebEN76Ay5U2tWOz
ND3ejlWJxiyBJ3e+zBUQ+znv8BaYVeYd0TkeSk/2Ys1v/yvI1MfnZKT6GW4Rx3MT
VuCMgFhsYh37aGWftLcPtlD1KuqdNUNI4E2Fz7gQt1kKN4VMQV3+mzS72D90JIt9
YytkRom9L1JoOCPKLT2xvuopLdc+eCaizTesxmVZsahglrxA+7eLqxMcpAwkNQ9r
kA/AI1wdUwCaJ2f1S1pac5wFMqdaqMiHg1G8aQJbUb1nFcC8bbgqpp9gg5oMndrS
oX+0PdYM4Dze3pLdDDUTGqSDQfbJ2Q==
=ZI+Z
-----END PGP SIGNATURE-----

--4bimetohzlxl6fm2--

