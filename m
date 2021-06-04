Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AECC39B62B
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jun 2021 11:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFDJph (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Jun 2021 05:45:37 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:43720 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDJph (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Jun 2021 05:45:37 -0400
Received: by mail-ej1-f47.google.com with SMTP id ci15so13501531ejc.10;
        Fri, 04 Jun 2021 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zik2ZOIHX9hVqZtBO1LNgsXDv6nOzHlOWXzcimwDP5U=;
        b=RDG5IKpVv6wDkvB0fJRqpPScvHke4gmzkoEh2vzKxmaKu/v9PAQsdRZwGWfhWfU/Ae
         TYMZmMduSHGhoXlqAeRf8BdsXtJmYVCkczSSUcxjd0JZbAMtndntscM+Q6w6BkfHiKAW
         sog7WvcDk5Ua2wbny43Mz+M3WJW1LK6et1mBeVpew0atAmZ7bpXhFxYy+xhQ6ppoJ0xh
         L8TN+qoYv9vXplizPibk949tbIXx4IrpYyT/X96UqdOfhXsqoK52sB2i+cxdK+Yc/3Sf
         5Xra48I7D5k1YUMTNMKvL0K6D+BW4ArsxWFb6zNiXToQ5vgGYNTiqCVaZ5NGLnVRxg46
         iBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zik2ZOIHX9hVqZtBO1LNgsXDv6nOzHlOWXzcimwDP5U=;
        b=MEJ7GVc/qCb/kNbB5D1A9l/5gQh8ejEsUdgeoRHnyyLiS84qWby1OqEASUBFdXb+Cv
         gkei+kodVn8rDVIfzAZJXuLunr5HlclesCO+eghnYq1uBxdnawK88nHC6vKW/1aRzBac
         J8gv6Xhu7pfElSktqi1WmXSfoHcOgk9THIFD8kRaxlBuGpXG8s4yOMl8LAAjVD9u9lVX
         uMrZnCoShCBRRvqzMSC9bk47yQ5diHTiWDeN8E1wk48s8Lng0uwA4aaLXvl3Ob3hVBbL
         SJrmeE7axKYIn+3eet7Fm7qStmLQ748+ogehXxmthbdOp6cwbCmnVkxvcEIQzTZMo9bC
         abeA==
X-Gm-Message-State: AOAM530SxBNPV/rLliAmxscq5IX3RAzYRscbWGYjKHlWbyXv+tnU0oy3
        jS2Q+xV4NvqkijCkkZD/6vTvXrhDjSQ=
X-Google-Smtp-Source: ABdhPJzPdM2aeP0hZSui987vcV8+Ix0Afrw4KOe5InV5KfJGNnubw2yDCSUIlXZYEseuq9VADKKxcw==
X-Received: by 2002:a17:907:16a5:: with SMTP id hc37mr3511453ejc.166.1622799770472;
        Fri, 04 Jun 2021 02:42:50 -0700 (PDT)
Received: from localhost (pd9e51d70.dip0.t-ipconnect.de. [217.229.29.112])
        by smtp.gmail.com with ESMTPSA id kx3sm2483748ejc.44.2021.06.04.02.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 02:42:49 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/4] pwm: core: Support new usage_power setting in PWM state
Date:   Fri,  4 Jun 2021 11:44:25 +0200
Message-Id: <162279984978.1091692.17557126430283544901.b4-ty@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
References: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 7 May 2021 15:18:42 +0200, Clemens Gruber wrote:
> If usage_power is set, the PWM driver is only required to maintain
> the power output but has more freedom regarding signal form.
> 
> If supported, the signal can be optimized, for example to
> improve EMI by phase shifting individual channels.

Applied, thanks!

[1/4] pwm: core: Support new usage_power setting in PWM state
      commit: 9e40ee18a1dc1623a5368d6232aaed52fd29dada
[2/4] pwm: pca9685: Support new usage_power setting in PWM state
      commit: ae16db1fd3a1b8d1713ba6af5cf27be32918d2b8
[3/4] pwm: pca9685: Restrict period change for enabled PWMs
      commit: 6d6e7050276d40b5de97aa950d5d71057f2e2a25
[4/4] pwm: pca9685: Add error messages for failed regmap calls
      commit: 79dd354fe1769ebec695dacfee007eafb1538d0c

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
