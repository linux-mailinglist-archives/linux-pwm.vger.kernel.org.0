Return-Path: <linux-pwm+bounces-5328-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B57A7A737
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 17:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71309188DDC9
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 15:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B202D250C0B;
	Thu,  3 Apr 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YxCgCCXM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E9038385
	for <linux-pwm@vger.kernel.org>; Thu,  3 Apr 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743695142; cv=none; b=Tg7UvAzxsXxKUF601+lE50Awd1bClT+8koKch5IwCiz82u3HSCLOJ3KfBZTagkKcowRzaE6PiOSx446jJ2RNYSc1+gbnFRxIx6DPyiRLNHB0kbr2RhJceNsa7HUEUokFLezaoMOXx/uIEftn39qhoA1CyQeHLcM7D59PPOq3XjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743695142; c=relaxed/simple;
	bh=iAAs5sBhDh3GOIIMyhxexUXGZEn+pFiw8EHMs4GxRSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnX3UrfbX2bUPdeyxqTTzLs6q+ArxbHJD1tYKEWxF2sCOpJ0bkRshPesn/Tt5bE2h5Dd66zRxhgJRXgFn5LLtFVqOad6OEv+Y2LnV81LKdtrw/8uCLyuQJ2brN9Tok3Xv4lt40jrEb2DG23x3v73vlnL07+qz8tCUgZQmq/TWzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YxCgCCXM; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so10601935e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 03 Apr 2025 08:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743695137; x=1744299937; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAAs5sBhDh3GOIIMyhxexUXGZEn+pFiw8EHMs4GxRSs=;
        b=YxCgCCXM3OWicxb5VLLhenQpLj5W0/4jQBy9/58lPBL9Q4mjI20zDfCEKViLjQBHyx
         eaQrW1BGJHnRRKNy/6e6iWHcgc2bdY70f+ZhPIztJiT1VGnApGdeZ7D2kN84SEIRZWQJ
         gLdhVN5liBWkQnhLTJQmVTY0unJgNlBVZbjU+uHBQLFeioRXYOuVFm9inB//vPV+Egql
         fcuiHQKYW5Vzls+nlRae1e7z+wTjznXqOeieRTbJlOVuByTG9+siOgrlueV3MEkYnjLq
         1COq4ALlgWBU1NynQHwRRHeGRLDyF6jhBI3s8K0NNbpxsq9f/rTed/eoOu85mbXasmpc
         L3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743695137; x=1744299937;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAAs5sBhDh3GOIIMyhxexUXGZEn+pFiw8EHMs4GxRSs=;
        b=rmPSASqYkuAAKhs/Z1mE+DP3ONH5Kz7ixYAeg2RxO8L2JSkgxsVdSEfx6lxCuKeYqo
         5IHgXZMgn/OXhUqKFcCile+0VdE9rjP/cuJ3ziHzjM8zPkcaawLraCk02see8b+eacgT
         Jl8hb5grBEhaWniE+4Iutlf4+d1ysPOK083WDsV2+ONsLud5la87j6XxHBmS/6BOZtk9
         B3iXEJP9WMCVIBVyMc0piYWNcpDg5qmhQu8WWTipYaD082tvWUmCcJBv3sN3GLA/AHke
         5A842lTQvkYAprcX8xyO7Tlo4IMcDUvozSVEulh7ij10JzSbAEaVNqWS2lfIWEedB6sW
         MZ9g==
X-Forwarded-Encrypted: i=1; AJvYcCWpfS56eTa5Q7iTaAqpsE21qO17Rwln/3GexJ6WWTZ4dsYl6sKT03oALr80M1PbQJySkc+W0dFEca4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4qlwRJ33jZg+81lKrb1TDMiFXOVe2bZAT8zBF0wpybKQ0ml8m
	DG/DjsQTgjS32yAcZiy8Tc05Jqd6wfu0FaWMnhdoxcBKWArDBWDFtVFNoB7CkUc=
X-Gm-Gg: ASbGncsi6nQ/+K0OEmiLG5RJjP+J6BMOCWoqNb/mrziY5gAuJDGihsO8fTmjMHoLSAB
	+9tdV7dLMc7+hRVDdZ4ete30XAGDoayIC8F5eLzd7KVwE71XY1rDtgD+iglFDJ/9a216HSYDgax
	fp03ViAgpHbzxxzDAZaXZcTNCuH3sFVQ79Cajj63SGDzP9hvbk/KBy6xddfWDjZ/lSDAMfqTpb7
	jMPcH+bSleTm3xNHaFit0IHY7u5Cq+Y4TOyY6UdnjGwSx4XSm4ijjE0Luo+GJH7lF0WXh4mH2OE
	ztpU6e3hcDHuJ1JyHZYeq6I2b2rCW3TF8CbGisAsk/bhjt4Z3VtnFwrVpCvakLcE9Gf21S4BJCM
	k1/TH9uJe/iA=
X-Google-Smtp-Source: AGHT+IEE+diWQwT3xdVd1/NUrTaV0zbs1L/rziH3lZrkM6YZXL2Micftxvudk2YHYcCtgwg5qaTPJA==
X-Received: by 2002:a05:600c:6dca:b0:43d:fa59:a685 with SMTP id 5b1f17b1804b1-43dfa59a802mr133654535e9.33.1743695137355;
        Thu, 03 Apr 2025 08:45:37 -0700 (PDT)
Received: from localhost (p200300f65f14610400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f14:6104::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43ec366aa29sm21727755e9.39.2025.04.03.08.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 08:45:36 -0700 (PDT)
Date: Thu, 3 Apr 2025 17:45:35 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Simon Horman <horms+renesas@verge.net.au>, Thierry Reding <thierry.reding@gmail.com>, 
	Patrick Havelange <patrick.havelange@essensium.com>, John Crispin <john@phrozen.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-pwm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 0/3] pwm: Fix division by 0 issues
Message-ID: <6hwirawnrsvyo5fer3km453fwhoic52st5e5enrctimatpirjp@lor5kdhnvuus>
References: <cover.1743501688.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vnasbrze7ocgubdr"
Content-Disposition: inline
In-Reply-To: <cover.1743501688.git.u.kleine-koenig@baylibre.com>


--vnasbrze7ocgubdr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/3] pwm: Fix division by 0 issues
MIME-Version: 1.0

Hello,

On Tue, Apr 01, 2025 at 12:28:58PM +0200, Uwe Kleine-K=F6nig wrote:
> I'll put them in my for-next branch anyhow for wider exposure. I happily
> accept test reports to (hopefully) increase my confidence in these
> patches.

FTR: I did that. The 0day build bot already found a problem with it in the
rcar patch that is already fixed.

Best regards
Uwe

--vnasbrze7ocgubdr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfurRwACgkQj4D7WH0S
/k7JeAgAsYjzNk8bIempZA0RtwLtBpw9k77opaBkwnfzeHOr2KIGeFwILhiIH5nQ
rQmZ6xP6Tth5QT0wSAWPrhhvkNPDo2VExXFDG2YkKWHxkR2Zour2JOLQVIU2JFhZ
Ubj3k+R9MiZQ2PEkXfd0OoWrLdG/hwhYDgD1Ui3MOE5AmA+B+iLQ01AhtaRjn0ZP
Ud709bne3Q19clrQPwy6l3v6Yu+Nekmyh3OMkCwsPMhOHYsaKuw0qe6GTbY6Psd/
MBH65M+fv17Ck6kDgUqU5AKHtGandmmnRBWx2BLRyFhQqIQmmAhOpwZuHpAqCahH
+qQKNDCHtkckEGjTsobRus/EnDCNoA==
=mH1Y
-----END PGP SIGNATURE-----

--vnasbrze7ocgubdr--

