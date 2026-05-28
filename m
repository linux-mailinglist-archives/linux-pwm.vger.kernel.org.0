Return-Path: <linux-pwm+bounces-9188-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDzkNNUCGGp+ZQgAu9opvQ
	(envelope-from <linux-pwm+bounces-9188-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 28 May 2026 10:54:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7315EF01D
	for <lists+linux-pwm@lfdr.de>; Thu, 28 May 2026 10:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BD27307B4DE
	for <lists+linux-pwm@lfdr.de>; Thu, 28 May 2026 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BBC38837A;
	Thu, 28 May 2026 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D06xo4wa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gE506u0m"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F23845DC
	for <linux-pwm@vger.kernel.org>; Thu, 28 May 2026 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958083; cv=none; b=iH0v6SBzNoK5DDAM/CUAY4SpeVutzH/i7jjO6ruwd8gUfhwVWshyRoYoyCrOzk6RS1k5egkowgd9djn2hNDzbKr6ObKP9WsiKrfBMin15DO7t++QbrToKyQ9OvZthUJoIVA9qTGzBKKs7zlw1S6/E/HtL0U0uZXtLvkrMN0GlUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958083; c=relaxed/simple;
	bh=SiiQ/8Pjo3hRAm8eRhuhyDhrCISkb1+d0Fn6rjQzIcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QDrUs/zjUKwqOsX9hJCK0K0Zd3Us9I9g2g8WRxN44po4DV1ciSexPP2eori5vlj6FvuoOtNupuKy0ePTutvO3qaHparVlDw5AaA92cEmXMToggF4pPOQQoo0kCxVcj+C7u3sDC5Te9YbTe9829jqa2RuX/ZRN7fht1LU2QRkapA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D06xo4wa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gE506u0m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S72oNs1638897
	for <linux-pwm@vger.kernel.org>; Thu, 28 May 2026 08:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oFz3XJI2yGl2SLYBsBNIOMTHUavJ/xUAME7pr/mxKvU=; b=D06xo4washJmnHQ4
	rbdbXIkPWeykYMtCpytbUnX06Dc7JDPdaDUaCt30fH2JwVLIdgHoEyrMel+ArvdU
	FDLAtI3865Fzwnf/u0kK0JtUcC/bUROA+//1yjx3EhM3ztWJ3gamyO38zeSkQtQU
	0zQCfNgjFgGsQFYC1VkDdRXV1HUL4XXFCNljo4HJYVNihs8Qdm+J7fGNRiAz+8wD
	b7KO1DS8j3JitasiMXHXz+2Ble8PKbB3qJQ3liPnRfQNvB8S82frDMXU56o5BIRM
	8yPaawnmA4yGkAQaEFjLoHGtduge7DpdMhB4aEjgv4haVv2j7/nUuzboyN/U9iqn
	mpp7Mg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynj2md-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pwm@vger.kernel.org>; Thu, 28 May 2026 08:48:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516d51ffb59so50806131cf.3
        for <linux-pwm@vger.kernel.org>; Thu, 28 May 2026 01:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779958079; x=1780562879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFz3XJI2yGl2SLYBsBNIOMTHUavJ/xUAME7pr/mxKvU=;
        b=gE506u0mSqTQ6XfVJ8bbod3rZTnz36De0uCkwhmfZWoU8LsO37y3aNQ308A6xEqQD6
         /R2a0+f0weT+lhj5qFOY66dknAHEI1OCly1bQx+NHmqtIuECRzQfx/KB1RREz4ERi7KW
         ozj/BbYoOsWVVS9fCs8p+oqPW/BWHkUyby2Li19EyFktJAJ2GbEdZL4/smt1lqeeZ9hB
         wYrPXJq2GWv5gV5usD+qzejbeN1Tn13g5Vs6Q+XSoJDVFmVDShH0XOso9/MZYaLLc0IK
         4tCqK4BTTApRQmjmLXMeAR2m1wjltaShujMM3ROlLn5bupsjnFn3EAQh1AwkKWKCO/ei
         csXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779958079; x=1780562879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oFz3XJI2yGl2SLYBsBNIOMTHUavJ/xUAME7pr/mxKvU=;
        b=BqIfxFLklutrDEE7clpttQmEHwpvzhpDyJdjyEnxtJ7YE/4gJnreGsJXDTsNdaIYp9
         iUUsA4mNEDDhcvz26tMRhQog6rmrun/IkIGxmOU6xBUg9FfOcXypXGtA6AdDYe18Ys7j
         6pufOsIa2loZ6dRSXy65lUak1J2HZ8kJjaIx7JulQTcNcAPRlb70QJwWUZBxOBdQIOZD
         TAbLdtizAZDv1GHmW8R5T17w+KAsUtj+jDDEAfU66K4kwAqgqnF6ke5H79lmYetPeGsa
         BPZ0VLtHz2MXCm7JgZzEXchESKV7QBJuQ8tTHWUZWOh/LZ/EjOanrTUV7eNzq7dovb24
         wWHw==
X-Forwarded-Encrypted: i=1; AFNElJ/Povr+S7sHe79Pam92ZH2roxVm9cIsva01ZjcPZ7ZaAp+VTOORgW1FqMjg3bxLisfdIy9rKcogxag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyHyTqXxFiVuaZ9ciw7qDQhFSvCj2v0xPQiUkSbhtW+6mVDY7y
	Pg2pceMqSV2k1YWuMv69VMIG/vX0LARIQMoyaftBT5hvhiRDQs0M1Vw5S+zUZjTX1sdQir0Ma7f
	DOSDl8PAWY7dGSeMogPgcDuEJEMjDjyvKs+hD5Z8QFZFrtoCK7rnOCIlMDbnAVVk=
X-Gm-Gg: Acq92OGskmGQSlv405asfCF9UzS5BtUuS78U6dnebn4YUs+OksnyEibzKMTiiAzHXNI
	2ePZBNi2yiJWaYtbPV3Zo0+nT8Ok03oAjr3o/AXtmEumCbb1LGvW9ivjr/Tn7W0jtW9H2EHznWR
	P7tAEBCfaMhVs/Nohpee6mEP8Jn7Qm3tem5udmHF8GwOWRsOHdXuEInLTysepjwR2DXUWsi9wWL
	NQrZoJwwQhh59/IEGsTDo7qOcOTjJVEsE+uJWY2xYoXdbod+3qCbe0EJar3cQbkS/fGnWhsMC/m
	MyokdqCGFCshuDZVQYMt7jqJKbKRCVSCrvBhEIIxU/0XUkxbnoc5gpLove2K/pxL6t3Dmz9HGKh
	EWodlMiwKLw4nMPT/b0TnqiUzi69qwBSnvymThh08tkLAUS2EFFjmbNHaVZDv8kOLV44G919InX
	QIGsCpSGCdO042M0KzFzvO4Mn5ww==
X-Received: by 2002:a05:622a:251a:b0:517:14b6:a2a2 with SMTP id d75a77b69052e-51714b6a335mr70490131cf.27.1779958079285;
        Thu, 28 May 2026 01:47:59 -0700 (PDT)
X-Received: by 2002:a05:622a:251a:b0:517:14b6:a2a2 with SMTP id d75a77b69052e-51714b6a335mr70489891cf.27.1779958078802;
        Thu, 28 May 2026 01:47:58 -0700 (PDT)
Received: from brgl-qcom.wifi.ville-nice.fr (62-193-63-110.as16211.net. [62.193.63.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908f0afc77sm10817465e9.33.2026.05.28.01.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 01:47:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Guenter Roeck <groeck@chromium.org>, linux-gpio@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v1 0/3] gpio: Use named initializers for platform_device_id arrays
Date: Thu, 28 May 2026 10:47:55 +0200
Message-ID: <177995803708.5037.5318741720946502441.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779893336.git.u.kleine-koenig@baylibre.com>
References: <cover.1779893336.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA4OCBTYWx0ZWRfXyIDidM8KgNxT
 T4DCv+ctqBdeF4BUO+hUy9B0L/Ev1EGJUCmhmzv+hachBvUEAt7oApRjQvWADsEpHecufBN+cdK
 n9/2M+udZDBCF/HzzDrRA95dDih4jsdSPJJq6p7DdN3k8weQmY1enoqkMBTKT+lewU2Ry8Ww9aE
 eWdjNAgp5XLXjagsEmRqRKqO7LMsrSr1ijkix73kVMC8uk4Xb5aLhZvrLPXo/2sG2nlCZ41lHjh
 waXrFdoe/BdfaIHIvcROUF4D/Hs0Ty7aWqFrI+DBzR1Wr9cIOVYZ/xNb6yIPt332b+xTyzinOSA
 off8QciP3hGvYBpZljk1sL/gu+LM6eccyyu+F+7+YytHxFeIpJPtLnmcdbeZJ00Kp/k//eA72gI
 b7kbTgk4renENxN8KzBHvReJgvNdO4VkNdNmS2W/630TsOrZ+uXK7mHE6w/g+UkpWnRp/PbJDcg
 ab8SNVgQhWtcQccdkMw==
X-Proofpoint-ORIG-GUID: 9FhKdj8B4BZ5-8E8DirdN7DawwXRQ0rP
X-Proofpoint-GUID: 9FhKdj8B4BZ5-8E8DirdN7DawwXRQ0rP
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a180140 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xizqlaZpAqmNt8UN1ov9oQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VaStRuOlacOtyYye708A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1011 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280088
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,chromium.org,vger.kernel.org,lists.linux.dev,ideasonboard.com,gmail.com,linaro.org,free.fr,iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com];
	TAGGED_FROM(0.00)[bounces-9188-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7F7315EF01D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 27 May 2026 16:57:26 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> this series targets to use named initializers for platform_device_id
> arrays. In general these are better readable for humans and more robust
> to changes in the respective struct definition.
> 
> This robustness is needed as I want to do
> 
> 	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> 	--- a/include/linux/mod_devicetable.h
> 	+++ b/include/linux/mod_devicetable.h
> 	@@ -610,4 +610,7 @@ struct dmi_system_id {
> 	 struct platform_device_id {
> 		char name[PLATFORM_NAME_SIZE];
> 	-	kernel_ulong_t driver_data;
> 	+	union {
> 	+		kernel_ulong_t driver_data;
> 	+		const void *driver_data_ptr;
> 	+	};
> 	 };
> 
> [...]

I fixed your SoB as requested and fixed up patch 2/3 as one of the drivers it
touched no longer exists in my tree.

[1/3] gpio: cros-ec: Drop unused assignment of platform_device_id driver data
      https://git.kernel.org/brgl/c/516e4d886941568174f46985fbb7c960c516ada9
[2/3] gpio: Use named initializers for platform_device_id arrays
      https://git.kernel.org/brgl/c/2d43fb71f4ecbd10649a277e8790e7ca27acfdfe
[3/3] gpio: max77620: Unify usage of space and comma in platform_device_id array
      https://git.kernel.org/brgl/c/a8754838f83a9905af516f38dd2633744a94f71a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

