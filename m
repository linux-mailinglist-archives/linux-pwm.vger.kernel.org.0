Return-Path: <linux-pwm+bounces-1481-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 504BB85474B
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 11:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13661F215E0
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C7B1643A;
	Wed, 14 Feb 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mMG2JxTY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072CC2C6;
	Wed, 14 Feb 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907171; cv=none; b=FJzoA3Ypi++EpL+TD3sT822akhVb33w450151Oe4iZHl6wBvzQoVXkGUzbY/mWncn454htSAuGBrNfEN2uHtAuGVn678YcGArMF5W3XhZrzkyjOty82/9x/9JIADWd0IXvpd8ZFZ+O2usv+mZQDsczoRrQcK/WVowfVbj7UnC/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907171; c=relaxed/simple;
	bh=ve+usHpPiLeGFo9qGaUdJEB8rWWmsI433I+8nLrtPWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwgDrO7mEgZcYTkhevuBOIU9qYcHTA949ICFlhD+zw/IcI9mkBrteUJrE0DjgPsi3rie2Vy2rDmxI0puEyXNYcqMQSdhrg7pCtQMICs7IsZfZeGIOOA0sUqFd2fdfi6zIgcH5e5bD6mVIg0/5TxJIl5T6xD5ZbtNZNAourHFMro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mMG2JxTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD63EC433C7;
	Wed, 14 Feb 2024 10:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707907171;
	bh=ve+usHpPiLeGFo9qGaUdJEB8rWWmsI433I+8nLrtPWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMG2JxTY5r0JtemuhnLGxIkBv2vs9oCD8JbPETLCQD3yg2qQ4VKFDBUVSU7yIge4J
	 4MrcD29ANaG2BIMVo3oS8op8fUmcTulSdxbxdcVYhZbgkqyOak9zrqsfNKhV+krgza
	 xLBeJ68UbUTpFQO+ditMDCSTVbcpZujlhg7+2k6g=
Date: Wed, 14 Feb 2024 11:39:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Benson Leung <bleung@chromium.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Paul Cercueil <paul@crapouillou.net>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-mips@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v6 001/164] pwm: Provide an inline function to get the
 parent device of a given chip
Message-ID: <2024021414-sedan-banking-f6b5@gregkh>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <cc30090d2f9762bed9854a55612144bccc910781.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc30090d2f9762bed9854a55612144bccc910781.1707900770.git.u.kleine-koenig@pengutronix.de>

On Wed, Feb 14, 2024 at 10:30:48AM +0100, Uwe Kleine-König wrote:
> Currently a pwm_chip stores in its struct device *dev member a pointer
> to the parent device. Preparing a change that embeds a full struct
> device in struct pwm_chip, this accessor function should be used in all
> drivers directly accessing chip->dev now. This way struct pwm_chip and
> this new function can be changed without having to touch all drivers in
> the same change set.
> 
> Make use of this function in the framework's core sources.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

