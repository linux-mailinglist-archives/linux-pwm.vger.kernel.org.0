Return-Path: <linux-pwm+bounces-9579-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K666NCX4SmrgKQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9579-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 02:34:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8C170BD6D
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 02:34:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=mLsuUED9;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9579-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9579-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21504300D454
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 00:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9FA213254;
	Mon,  6 Jul 2026 00:34:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC16B1A9FB0
	for <linux-pwm@vger.kernel.org>; Mon,  6 Jul 2026 00:34:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783298074; cv=none; b=DOMI+7QTrRL9eO1CG+22f3/Z6dl4hS01YvysJQCWmofk+MLETTDDi9LLlyJscXdVz96DU8PkobKk/LMfuLAhCI/jmy3KLJY54WJCNICjyVR7T1k6foYhQDcHSOovFUWNotNFJiyywhSJD/xCp//3Y6TP/ILy9KfnVzYpoQplfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783298074; c=relaxed/simple;
	bh=2PxUxZPMKUCuY9XPy73Y/KPmQ0r97rw0cg10OraDCjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MniUEvLZE7TQUMdzBxO5g1ILB0hnnMm6y/btqyk9ETd4W0MbZ9QtySMBXk/EsKId4Zju1cL1g07EGmWZsrLchRYCXm2Osk6FnND68qn4Zx69KE5P6clPKuD7aVF/+keTm0dwA78vozKQA+ikaVAKQQ/efNrsRZl31QgTFVsVWQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mLsuUED9; arc=none smtp.client-ip=91.218.175.188
Message-ID: <973f3d6f-6ff4-4685-9c9f-b07987f74d98@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783298059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wYrjdzAhnc0P88BFwUH/b6uj52WFQfIRb2R1u4QFCds=;
	b=mLsuUED9ENIp3ed3h8bdKFYcEwFgoRzOELLNc1jLIXF6taZ+WEztXLwd9/BAKQWvUz2Hs3
	3EKLIatmB5Z+Df3dgdlCr8bmpTJQbWFj3Jp6WCvzaQnW40BXVB4LUsJRj7jQdhncagFIYu
	oCbFYryMjDBm1fu5il4d+x3rl9gBRyM=
Date: Mon, 6 Jul 2026 08:33:47 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 4/5] pwm: Unify coding style of of_device_id arrays
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, linux-pwm@vger.kernel.org
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>,
 Vladimir Zapolskiy <vz@mleia.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Paul Walmsley <pjw@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Michael Walle
 <mwalle@kernel.org>, Inochi Amaoto <inochiama@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Hammer Hsieh <hammerh0314@gmail.com>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Alexey Charkov <alchark@gmail.com>, Sean Anderson <sean.anderson@linux.dev>,
 Michal Simek <michal.simek@amd.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, chrome-platform@lists.linux.dev,
 imx@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
 linux-sunxi@lists.linux.dev
References: <cover.1783263835.git.ukleinek@kernel.org>
 <20de6cd60c2938aad2d21397b92742849418ab1b.1783263835.git.ukleinek@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chen Wang <chen.wang@linux.dev>
In-Reply-To: <20de6cd60c2938aad2d21397b92742849418ab1b.1783263835.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-9579-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:linux-pwm@vger.kernel.org,m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:rjui@broadcom.com,m:sbranden@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:florian.fainelli@broadcom.com,m:bleung@chromium.org,m:groeck@chromium.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:paul@crapouillou.net,m:vz@mleia.com,m:piotr.wojtaszczyk@timesys.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:heiko@sntech.de,m:krzk@kernel.org,m:peter.griffin@linaro.org,m:alim.akhtar@samsung.com,m:pjw@kernel.org,m:samuel.holland@sifive.com,m:mwalle@kernel.org,m:inochiama@gmail.com,m:orsonzhai@gmail.com,m:baolin.wang@linux.alibaba.co
 m,m:zhang.lyra@gmail.com,m:fabrice.gasnier@foss.st.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:hammerh0314@gmail.com,m:nobuhiro.iwamatsu.x90@mail.toshiba,m:alchark@gmail.com,m:sean.anderson@linux.dev,m:michal.simek@amd.com,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:chrome-platform@lists.linux.dev,m:imx@lists.linux.dev,m:linux-mips@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-renesas-soc@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-samsung-soc@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:sophgo@lists.linux.dev,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-sunxi@lists.linux.dev,m:martinblumenstingl@gmail.com,m:matthiasbgg@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[chen.wang@linux.dev,linux-pwm@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[kernel.org,jannau.net,gompa.dev,microchip.com,bootlin.com,tuxon.dev,broadcom.com,chromium.org,nxp.com,pengutronix.de,gmail.com,crapouillou.net,mleia.com,timesys.com,linaro.org,baylibre.com,googlemail.com,collabora.com,glider.be,sntech.de,samsung.com,sifive.com,linux.alibaba.com,foss.st.com,mail.toshiba,linux.dev,amd.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,st-md-mailman.stormreply.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[66];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chen.wang@linux.dev,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B8C170BD6D


On 7/5/2026 11:14 PM, Uwe Kleine-König (The Capable Hub) wrote:
>   - Use a single space in a of_device_id array terminator; A single space
>     after the opening { and before the closing } in non-empty
>     initializers;
>   - No comma after an array terminator;
>   - Also no trailing comma after a named initializer iff the
iff -> if
>     closing } is on the same line;
>
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

[......]

> diff --git a/drivers/pwm/pwm-sophgo-sg2042.c b/drivers/pwm/pwm-sophgo-sg2042.c
> index 7d07b0ca7d29..0b6461172e6a 100644
> --- a/drivers/pwm/pwm-sophgo-sg2042.c
> +++ b/drivers/pwm/pwm-sophgo-sg2042.c
> @@ -225,11 +225,10 @@ static const struct sg2042_chip_data sg2044_chip_data = {
>   static const struct of_device_id sg2042_pwm_ids[] = {
>   	{
>   		.compatible = "sophgo,sg2042-pwm",
> -		.data = &sg2042_chip_data
> -	},
> -	{
> +		.data = &sg2042_chip_data,
> +	}, {
>   		.compatible = "sophgo,sg2044-pwm",
> -		.data = &sg2044_chip_data
> +		.data = &sg2044_chip_data,
>   	},
>   	{ }
>   };

Changes to sophgo related files：

Reviewed-by: Chen Wang <chen.wang@linux.dev>

Thanks,

Chen

[......]



