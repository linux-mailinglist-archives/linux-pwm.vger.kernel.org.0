Return-Path: <linux-pwm+bounces-8382-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uD9hH11Axmm7HgUAu9opvQ
	(envelope-from <linux-pwm+bounces-8382-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 09:31:25 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C561341012
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 09:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E32930E8C45
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Mar 2026 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23913D3D12;
	Fri, 27 Mar 2026 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYbU4xPW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A53C7E0E;
	Fri, 27 Mar 2026 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774599927; cv=none; b=NTrH0Caeo7K4WpFEx0DF7r75soHYYTKnNwwzEEWvommHmyXUErozIPhD6t/U99fcaZP4qRkecvQrMTd/HPCQOcsXmTZ7u0HiIslffbO5jVrdh+dC1RxXTCdq+Ru0L/z4z0OD08PgcajzquI+4KDETAQG92CFQXp76azuoRX6jsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774599927; c=relaxed/simple;
	bh=HFmd/yN0zDbunaZil2hF63355iXilUJ4h7GpPaZQYk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPqBJYksHU/z+FRiIF1txhzXcsMh4zNb7uzCAq7UFbPwRWA7hZUfFs1IWDqu/RbLC72NpUJSKrQHa9MnOqE758Y5I2cBHl19MwRRl9xDBrNMHmXE5yBGiYXMdKKYrSiBjpn/9Ew744pMsE9VNZ7gX8kVN2arDhUoZfruAnfu5DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYbU4xPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEFDC19423;
	Fri, 27 Mar 2026 08:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774599926;
	bh=HFmd/yN0zDbunaZil2hF63355iXilUJ4h7GpPaZQYk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iYbU4xPW0QmniiP7pbZ2rN5WhRhXZl3OHs06Um/vct+r0dI26c2lvARKJzAwNK1fW
	 L22HxRlPr8pUt519LPW9Ge1QpOX5zfz4I1s2QPszCUrd1PB13gjuL06F3x82aS8fCE
	 QGg8YO3/6RNnGhbG81KrSkCmBfFEaiM8shU/8RuCG42h5GcqGmlClvtrZ4Y6aV/mjS
	 Q8Kl1/VLOdj/g8dirfcHT0w8Gl0cRPCa0CPo2IVjsCOyUDWFH0g/juNL0GL4Diib7S
	 G26MGyL6C13drt6+H1StyHY9m0pMyjNGFfV2Ub94odhO45eEnvLa7PVsGoVsd4cNKi
	 aDO14AE8Xs3Fg==
Date: Fri, 27 Mar 2026 09:25:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	Junyi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH 1/2] dt-bindings: pwm: amlogic: Add new bindings for S6
 S7 S7D
Message-ID: <20260327-cormorant-of-strange-spirit-d8fdc5@quoll>
References: <20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com>
 <20260326-s6-s7-pwm-v1-1-67e2f72b98bc@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260326-s6-s7-pwm-v1-1-67e2f72b98bc@amlogic.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8382-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,googlemail.com,vger.kernel.org,lists.infradead.org,amlogic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.3.232:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 9C561341012
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 06:35:38AM +0000, Xianwei Zhao wrote:
> +      - items:
> +          - enum:
> +              - amlogic,s6-pwm
> +              - amlogic,s7d-pwm
> +          - const: amlogic,s7-pwm
>        - items:
>            - enum:
>                - amlogic,meson8b-pwm-v2
> @@ -146,6 +152,20 @@ allOf:
>          clock-names: false
>        required:
>          - clocks
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,s7-pwm
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: input clock of PWM

so simpler: "maxItems: 1"


> +        clock-names: false
> +      required:
> +        - clocks
>  
>    - if:
>        properties:
> @@ -182,3 +202,10 @@ examples:
>        clocks = <&pwm_src_a>, <&pwm_src_b>;
>        #pwm-cells = <3>;
>      };
> +  - |
> +    pwm@1000 {
> +      compatible = "amlogic,s7-pwm";

You already have three examples, don't add more.

With these changes:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


