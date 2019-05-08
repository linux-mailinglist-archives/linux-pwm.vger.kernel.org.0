Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A418318257
	for <lists+linux-pwm@lfdr.de>; Thu,  9 May 2019 00:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbfEHWmN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 May 2019 18:42:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39117 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbfEHWmN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 May 2019 18:42:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so195567pfg.6
        for <linux-pwm@vger.kernel.org>; Wed, 08 May 2019 15:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=BFe1QuxITumk3NtRUI5j6KVRf7tiVcFp6Ull8WpK1V0=;
        b=Mfvex9BFV2UhWcSvsxNqdfZF62RCtCtQrieU/ecep5z0+LlSwxbxe65oc8BqrABrVY
         D0GgFHhiO8JYLmuzd9gChNaLR/+E/4/JuekTQG9zwQPg75Bs8vW3zLWyFJjZSmvU3Wzh
         Rw4Yswz3b3zvMXAyyBahCY4JHGXRMcXjnuW49PAE3sO3I/urY9+uZjhcCAD0YoN02F6N
         3LLwm9nr6HAM+XI30F0kWBh2vNMSNm4yJqmJOHo6mrUCXT1peZ6OWylRIId699L57jnG
         WGOAag2H5f5NQtfOGri0KFAlW8SBMISCuDMeOc6pZx1RGPgYRw64zuvWYZZXU53m/Hof
         Kzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BFe1QuxITumk3NtRUI5j6KVRf7tiVcFp6Ull8WpK1V0=;
        b=kYRjPDTpcRrjJeiRxtwYK9RgPJee/n8nW1+V2b8ISHb/HAouK/aaIDGlaWll72/a8s
         BKZuchK2tsNOMGJY90NrGMwkyLABfjicAd5OQ3TxwvJ3bNSSbDjJPq9rjyU1Ey1NVjK7
         lWGvNko9SG6UMvlv6nOMKXQ55hbEcnGMaj2JTOp4uWj5klOhHG25a6QG4V6A2rycZipZ
         q+EYKXdFK9lrLTULjV/44NqNcyKYkAFvuj67DMF+Ely6P6zDZHLhWw6DdLGYKRwCiH8A
         1zKmO96AvslYUvCPDcaG0o4U76fxLPlxRLIyiX/YNjgUf2q1K7Kb0Ieabbi7UGcLvGYe
         Nx+A==
X-Gm-Message-State: APjAAAWNWW6kF6XpxLYIJLlJmiHVSppEpm2JQCck9Fetmids36KUlKqp
        sIqBGJ44FS9vbRxjVkvCIwd4hw==
X-Google-Smtp-Source: APXvYqx/VVXouF8rOT0oIb+thKazr2gkUBTz+7SSmre3OHZnik0jMYM3EW1igez7W+lucMT7jJVS3Q==
X-Received: by 2002:a63:1558:: with SMTP id 24mr900283pgv.126.1557355332383;
        Wed, 08 May 2019 15:42:12 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:a864:57af:5348:a6ea])
        by smtp.googlemail.com with ESMTPSA id u123sm376416pfu.67.2019.05.08.15.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 15:42:11 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, thierry.reding@gmail.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: meson-g12a: Add PWM nodes
In-Reply-To: <20190423133646.5705-4-narmstrong@baylibre.com>
References: <20190423133646.5705-1-narmstrong@baylibre.com> <20190423133646.5705-4-narmstrong@baylibre.com>
Date:   Wed, 08 May 2019 15:42:10 -0700
Message-ID: <7h7eb0in5p.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> This adds the EE and AO PWM nodes and the possible pinctrl settings.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl<martin.blumenstingl@googlemail.com>

Since bindings are acked, and there's no build dependency on the driver
itself, queuing this for v5.3 (branch: v5.3/dt64)

Thanks,

Kevin
