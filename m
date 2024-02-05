Return-Path: <linux-pwm+bounces-1203-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736D38493A0
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 06:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FD01F239FF
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Feb 2024 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA38BA34;
	Mon,  5 Feb 2024 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KHsqvi/r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0CB665;
	Mon,  5 Feb 2024 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112702; cv=none; b=KOwbemLE2AM9CIicvC0ftFKkYTDq/Fh7on77BlfsAjwdAV+xAD5R8idFE7ar4xPvXwaoPWNWmfG8vQvTs9X9UqTZmUBlv2FfW+xLA1d0f/2ZhWDNd5C3Y4KKWO+Ny+N3cKAV+n+gsX/zW8/MO3kUnlUSTL3br6/815hcGBNu59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112702; c=relaxed/simple;
	bh=Q5cL3VZHhWWgMitcqAPRYi39rulmGYL2Sqpx1eU39/w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmQaLTQj3VRC+mB/oxaO5u0Me3wlgZCtm4xFJKith6SUWSv0k1sKnMc2FSX387oyIA2Qg0egj87wAosxBnzAlCMSwgsotD+qzYO/rr4zxsUPuq930aQIhpLx55XkBn5MeG/9jMKE+LfTo7NcBwT9HzqxDxOTgpCYFSBQSoNtAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KHsqvi/r; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4155w6nU018649;
	Sun, 4 Feb 2024 23:58:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707112686;
	bh=hX7/OBfKrLVgA7JwZ/8IbuM/IWF54HIRzbN56lhGEhU=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=KHsqvi/r5ijOks1A4l3F4i6qd1rHlSXSTVXiZpex0+p1Neip+H9f6eGBmqu/f3m9e
	 KeINFbBWHcBC6VnTfdpepuXG2ilsM+PA1dUakxT9MUAis3sLBrnmhOnFd1jAwBbEuj
	 advr+HW4U2v1OIR7kCPMklliB/lSBj5F0MrX4t8A=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4155w636081523
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 4 Feb 2024 23:58:06 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 4
 Feb 2024 23:58:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 4 Feb 2024 23:58:06 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4155w5a1120889;
	Sun, 4 Feb 2024 23:58:05 -0600
Date: Mon, 5 Feb 2024 11:28:04 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Stefan Wahren <wahrenst@gmx.net>
CC: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <andy.shevchenko@gmail.com>,
        Angelo Compagnucci
	<angelo.compagnucci@gmail.com>,
        Philip Howard <phil@gadgetoid.com>, Sean
 Young <sean@mess.org>,
        Linus Walleij <linus.walleij@linaro.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Nicola Di Lieto <nicola.dilieto@gmail.com>
Subject: Re: [PATCH V4 1/2] dt-bindings: pwm: Add pwm-gpio
Message-ID: <20240205055804.f72etija5d6xxixw@dhruva>
References: <20240204220851.4783-1-wahrenst@gmx.net>
 <20240204220851.4783-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240204220851.4783-2-wahrenst@gmx.net>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Feb 04, 2024 at 23:08:50 +0100, Stefan Wahren wrote:
> From: Nicola Di Lieto <nicola.dilieto@gmail.com>
> 
> Add bindings for PWM modulated by GPIO.
> 
> Signed-off-by: Nicola Di Lieto <nicola.dilieto@gmail.com>
> Co-developed-by: Stefan Wahren <wahrenst@gmx.net>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  .../devicetree/bindings/pwm/pwm-gpio.yaml     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-gpio.yaml
> 

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

