Return-Path: <linux-pwm+bounces-9586-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WV4zOu5nS2qBQwEAu9opvQ
	(envelope-from <linux-pwm+bounces-9586-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 10:31:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B5D70E1E8
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 10:31:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=jm0Kg9lS;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=iySRmemb;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9586-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9586-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A412A3030D33
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 08:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587803F54AC;
	Mon,  6 Jul 2026 08:28:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBA53BD646
	for <linux-pwm@vger.kernel.org>; Mon,  6 Jul 2026 08:28:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326510; cv=none; b=s58uvVF4KCeDziinYlZEGImeAic8vzEwb7ziqKKxD6lGudKFaPM1QNBZFhpbDbpNdj2EpDzG+38ZqAHAGnhEp89dQn7XIT9Ozn86qNM9V7cK61dgUANNgsKDRGAEcYiPg9KXFF7GPBn4Le6xxVsZqPLuY4C8Dyu4tmI4RBWfsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326510; c=relaxed/simple;
	bh=JJvjvXzlCcli26w+i5Hirhm7MyXZ6wjDQGioyQ2O3Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rVGRdY8VM0WV/F4z6e3Wz0XfDN7G3Vq04BveKWWtQHVxpghfvtadWlxwGE/Y4/nY4C2buaBuVC68RlCXcs7NsJrlSKkStkrhx/ubXoBCFzDOQDfxm8eYkI4LoyHPeOiyvPdN7vKyUkuriAGgWOcRQ20YndlNVHlNRP4XtPXgnC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jm0Kg9lS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iySRmemb; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66678Mwf3976835
	for <linux-pwm@vger.kernel.org>; Mon, 6 Jul 2026 08:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XAhBIVcIgoBMwzdmQI01e6U2QYtMrrtbbOHKP8KiZ8E=; b=jm0Kg9lSibJvV8Yi
	8hdJzAn4zgpP2byZ5O4vxPHA667bXVLXHofUt568kB49iHxnfwvFhctaInLtCjCZ
	sjNHRodxgeyEI+K4Sh5SeEFuH+eYubHtMfiWH/bAUEFyu7LxqpBoChobn1qyHVpZ
	1rLLI4FJJqj/Yk953HEONXVBT+N6ylBmW+SjTQeQEVhfTmxCK8O9BG8vaRt3Exir
	JXmS8JQhSMmJuTk8SMinF8d+mY+jVTVBRkY8NqkZa2/Ot0bSxasJBedLFZ9P4/jy
	oIqrv4PZJHfl9zhVgr7IHFht7qp40w3MPq61gyA4heu2IH0hVtB6bY7pBm7HdH1D
	jKj/ig==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87q7g9yg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Mon, 06 Jul 2026 08:28:22 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92da6f3cc81so339735885a.2
        for <linux-pwm@vger.kernel.org>; Mon, 06 Jul 2026 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783326501; x=1783931301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAhBIVcIgoBMwzdmQI01e6U2QYtMrrtbbOHKP8KiZ8E=;
        b=iySRmembnVhfpHKv0P7A0FJrfFYQzoeqNTFUQsMNZtw3CdGU4Q4fhRAIqVC/JCiTZs
         Wn1byb5svaDvve48T8YdEmb/owBPxAkGD/r7jITxnhtFof8dompNFklgZ1pOdYBO/Xl4
         7xTKlHejaHyD1FCYwSDXaADC3dONm/vNYGkAD82K1cm6jFaDRRmS53nbzP7wJ3yWpL4R
         6QHM5adLsRVt2cW+lBTtHwfHvolUN9rZLjZx3fX7p8EIzEhRkbi6t8AJo06INVT2KwIb
         iWnTXXUSSeyGpYmceJuOc+kupegEZbO4+TLjVssJg4i4XW2R8CWQcvSZHSkod0EgIX5O
         GVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783326501; x=1783931301;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAhBIVcIgoBMwzdmQI01e6U2QYtMrrtbbOHKP8KiZ8E=;
        b=GaU6fe5WXh6wf6tcuCzbK9VwdjXmtwAzgSTvrmBzABsGhArBydz40YFvz78JkqTHT6
         DmzppylYZj2N6rzW+zpqgeehVHE8aNCL7aKoFq711g6Ba51nFzd8PsSzLkWloW4yj9UA
         rmIPjOWpXMLLql7z1tVuchaRdaaDSyb3nNlNi/FR9tMOQs741BHgnpjR/hTajDyH9EMl
         cfNlIxUdEx0sLL4iWvjgKmuZdvQ3GKXBTfSmx9Q26dj5LIZeOsTmwtPLCpsKs/43Q+zl
         F0fQ/Kd14U0WPK0BrTTi7fCOBHzZEdquqigDBPA/ZnlOWYyyFD+F+Zg4aVTtP0aXPvKi
         tQGA==
X-Gm-Message-State: AOJu0YwXbZunk4B2adOoHQPj6wKq+qLM/ijBTwjYzcC3ptJdIkrfu9eT
	d9wPXhn7zgwYbVuwdUD95uhWKp97C+frQdD465+YSpv3UH+cy9ir2EssZ4sfa/oOJECCXvDy4uU
	4mMf9iCXzwBPVvgLbSrWlU4+zFsWyU6KFbe2iRn5L+PFpcEexERDkZqZHv4s3D3A=
X-Gm-Gg: AfdE7cliQx0dua/EOAF8fgS8/HJqv5ze0jUFjF1VBc07hpNsS7oOEFKA8dA5AfpjSFx
	IEgLLuSKX/hON67+MEyE51cuuG20bsAnVaF10hN0r0v5Sg7+M9mqXvtLBjY1PueQJr6VIvj3uEC
	FHCiDDWqzyCQd63BFx+oj4or341r1dqZkwNEdEqTpOhwKhNAkoejwA0rxR3rsHlovPRGzwnty86
	rnOtixFuLvzJD48Pic4g0ZOFCDEWSVwOnHZAMr0lkOfZxPRHZ5Eg5plbCEz0y/ODJa8gHWVg8sL
	FuHHe/xDAgyzrJ6tauteOnWeldTCva6tezXTq3FEIZq22x8wz6Dyj4L5bi4rdHtdKkwH95RNOSH
	QG65udg+CbyDKsJ518h3tK5cDyeo3ufS7PRtv0YAXnKAaCeflWrbtO2BjJSzaxQ==
X-Received: by 2002:a05:620a:2b84:b0:92e:47d4:b485 with SMTP id af79cd13be357-92e9a4ed0e1mr1294195185a.62.1783326501628;
        Mon, 06 Jul 2026 01:28:21 -0700 (PDT)
X-Received: by 2002:a05:620a:2b84:b0:92e:47d4:b485 with SMTP id af79cd13be357-92e9a4ed0e1mr1294189385a.62.1783326501174;
        Mon, 06 Jul 2026 01:28:21 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62907absm677939066b.33.2026.07.06.01.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 01:28:20 -0700 (PDT)
Message-ID: <bc697542-b1e2-41c2-af36-b708ca4aad5c@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:28:16 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/5] pwm: Unify coding style of of_device_id arrays
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
        Chen Wang <chen.wang@linux.dev>
Cc: linux-pwm@vger.kernel.org, Sven Peter <sven@kernel.org>,
        Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>, Paul Walmsley <pjw@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        Michael Walle
 <mwalle@kernel.org>,
        Inochi Amaoto <inochiama@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
        Alexey Charkov <alchark@gmail.com>,
        Sean Anderson <sean.anderson@linux.dev>,
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
 <973f3d6f-6ff4-4685-9c9f-b07987f74d98@linux.dev> <aktWoIfY_DdO6gb4@monoceros>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <aktWoIfY_DdO6gb4@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfXxb45KQPn5eFJ
 THVdmtgKV1hT1WGx4o0XXfxahvmv0r3hVYnJumYBjcy6QpqS4l6oAlSXHkeni/gucuwleJKEQBE
 9NuZ4eHBgY3GXYCzfXAXYc9DbcDjhseCJ3tTfn/pIT/sZzNb2Ur1YWE0QnGj9ZyR8oi28AKF9T9
 rbqhKQ/duDX13Zy8dBVn18UzOUt7pmqT1TMzpPmOdTwg1f6tWiTNrSxEdCLIm9qybe4j8OND/Yo
 +4H+uYklIJkHuW2NbAyUGPvmQt6fe2/iCmlRCTHO6/4ahdedJMnG+CdOvhcL74SlxmfhVwj/3Nc
 v2/vK88hEI7PsCdHh01pT1HeJuBXW85dYudpPWz/sbJshkebkHqNZPfWH3qMM+IOt6yQ8mX8v5U
 a935lBFv3lE9TnGh5CyvRnOzhhoFU5nGiLxpefUo5WGbyyYvbnnrjTlC8ruR8fiiIf7uOp0a522
 USsp1JVMvBCJFny1J0A==
X-Proofpoint-ORIG-GUID: WiLm5BlfSurFGglttBBVDfQbmRtT_Lyv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA4MyBTYWx0ZWRfX4vhpn+xVof3D
 8bbxdSyTtb7CSFebJBbxTZtcMgp0lw+FBUJHWBj5XXCY2QCydhKe5AK4UZ5NsMdy3QrW3Phb/uJ
 hbHKEHvEIaTFI4OtZap46IFqhcLaycE=
X-Proofpoint-GUID: WiLm5BlfSurFGglttBBVDfQbmRtT_Lyv
X-Authority-Analysis: v=2.4 cv=f9N4wuyM c=1 sm=1 tr=0 ts=6a4b6726 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=8pif782wAAAA:8 a=IpJZQVW2AAAA:8 a=TiEZW8bMWLlPbLH3YMsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060083
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,jannau.net,gompa.dev,microchip.com,bootlin.com,tuxon.dev,broadcom.com,chromium.org,nxp.com,pengutronix.de,gmail.com,crapouillou.net,mleia.com,timesys.com,linaro.org,baylibre.com,googlemail.com,collabora.com,glider.be,sntech.de,samsung.com,sifive.com,linux.alibaba.com,foss.st.com,mail.toshiba,linux.dev,amd.com,lists.linux.dev,lists.infradead.org,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9586-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[philmd@oss.qualcomm.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:u.kleine-koenig@baylibre.com,m:chen.wang@linux.dev,m:linux-pwm@vger.kernel.org,m:sven@kernel.org,m:j@jannau.net,m:neal@gompa.dev,m:nicolas.ferre@microchip.com,m:alexandre.belloni@bootlin.com,m:claudiu.beznea@tuxon.dev,m:rjui@broadcom.com,m:sbranden@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:florian.fainelli@broadcom.com,m:bleung@chromium.org,m:groeck@chromium.org,m:Frank.Li@nxp.com,m:s.hauer@pengutronix.de,m:kernel@pengutronix.de,m:festevam@gmail.com,m:paul@crapouillou.net,m:vz@mleia.com,m:piotr.wojtaszczyk@timesys.com,m:neil.armstrong@linaro.org,m:khilman@baylibre.com,m:jbrunet@baylibre.com,m:martin.blumenstingl@googlemail.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:heiko@sntech.de,m:krzk@kernel.org,m:peter.griffin@linaro.org,m:alim.akhtar@samsung.com,m:pjw@kernel.org,m:samuel.holland@sifive.com,m:mwalle@kernel.org,m:inochiama@gmail.com,m:orsonzhai@gmail.com,m:baolin
 .wang@linux.alibaba.com,m:zhang.lyra@gmail.com,m:fabrice.gasnier@foss.st.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:hammerh0314@gmail.com,m:nobuhiro.iwamatsu.x90@mail.toshiba,m:alchark@gmail.com,m:sean.anderson@linux.dev,m:michal.simek@amd.com,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:chrome-platform@lists.linux.dev,m:imx@lists.linux.dev,m:linux-mips@vger.kernel.org,m:linux-amlogic@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-renesas-soc@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:linux-samsung-soc@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:sophgo@lists.linux.dev,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-sunxi@lists.linux.dev,m:martinblumenstingl@gmail.com,m:matthiasbgg@gmail.com,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,wikipedia.org:url,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[philmd@oss.qualcomm.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[67];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46B5D70E1E8

Hi Uwe,

On 6/7/26 09:19, Uwe Kleine-KÃ¶nig (The Capable Hub) wrote:
> Hello Chen,
> 
> On Mon, Jul 06, 2026 at 08:33:47AM +0800, Chen Wang wrote:
>> On 7/5/2026 11:14 PM, Uwe Kleine-König (The Capable Hub) wrote:
>>>    - Use a single space in a of_device_id array terminator; A single space
>>>      after the opening { and before the closing } in non-empty
>>>      initializers;
>>>    - No comma after an array terminator;
>>>    - Also no trailing comma after a named initializer iff the
>> iff -> if
> 
> This is actually intended. iff = "if and only if", see e.g.
> https://en.wikipedia.org/wiki/If_and_only_if .

I agree this scientific idiomatic expression is not well known
by non-native English speakers, and using the expanded form is
just simpler to review (thinking at non-native English speaker
reading your commit in the future).

> 
>>>      closing } is on the same line;
>>>
>>> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
>>
>> [......]


