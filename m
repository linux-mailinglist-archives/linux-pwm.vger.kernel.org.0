Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94BB39B631
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Jun 2021 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFDJt1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Jun 2021 05:49:27 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:46625 "EHLO
        mail-ej1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDJt1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Jun 2021 05:49:27 -0400
Received: by mail-ej1-f51.google.com with SMTP id b9so13497702ejc.13;
        Fri, 04 Jun 2021 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9FxBruhZCAwsrN7wIzOLFumqJ5iiDm9SEVvrFgi6Ir0=;
        b=vHwyrVBnwK6rZWy0x9SjQXqfvtUwEpwSchXOdnB3/1qDIyyxNt0PK6wKwbtvg+7GuU
         SLsl1rire99hvZS6qdoeE9+EHOY2/LJLAtJ2Tg8KUG86vqqd048/LADwm94hOKSCiH9y
         a4gS2gB4pHJuAUwzGGwgl4zKYTa7OJ+FZrLYNVpiBtGQQZuvmjimRBh7QNbKhRRo7/i6
         2Zq4B+2b8/BXUFLxXTyEsvzBKH63L6/fPaN5uNERoWt0qPwJEwi9BzzsOFm+waVQ31J8
         4TjnXmGxE3EJ2Q1QurG+hIwJz1sg1tM8+lEQ7SILtAkHv5u4U36Ca5w7mCkbS3pXzevj
         KWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9FxBruhZCAwsrN7wIzOLFumqJ5iiDm9SEVvrFgi6Ir0=;
        b=Hwo7JEtJP9DGJVrvg4+Uq8HcWnZih5UHAGTh2zteTsx2+C86FHQ3mEtAMWf9CtNuX4
         LZ9rYYr5SByv5RbdUV3FoNrPETRvKiUMy9KLkpLoqqL9gq2LP7jQMbv7a3vOHe5KBMaj
         5FjKttthcPBgYcMNsxc9q8rvqKHRBLm/pq8l91S0Url4aM7sHOLK8wTcQkp7lQYJASzp
         bSJRuxq/yJtBcu/KxGt82s1FUqItx+AUkXbn/BDOnR1+bgZDlPVikAxsiMRKAZtNQ4qR
         Nfpd8Objh0wjDnLxEBVgQTzQrw1sRE/oHtONf1RxFeD3kwxlxcxayFOUMx73xneXUl7B
         Xeug==
X-Gm-Message-State: AOAM530YAWZ5nbZx31ims1AI+RbDSm5JyCT5Ou6PsfrpR+7E82IPLdEk
        osroaR+Lx0OjxJUaOtdico8=
X-Google-Smtp-Source: ABdhPJxFVJDwF3AgTdvGe/XsXcsdTHUNYaxZERzRL77kvdOeTN7g+sA2wBjgNm11BtAnlBBNCgwoCg==
X-Received: by 2002:a17:906:8056:: with SMTP id x22mr3247582ejw.298.1622799989130;
        Fri, 04 Jun 2021 02:46:29 -0700 (PDT)
Received: from localhost (pd9e51d70.dip0.t-ipconnect.de. [217.229.29.112])
        by smtp.gmail.com with ESMTPSA id n26sm2566605ejc.27.2021.06.04.02.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 02:46:28 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de
Cc:     Vignesh R <vigneshr@ti.com>, linux-pwm@vger.kernel.org,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        tony@atomide.com,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] dt-bindings: pwm: pwm-tiehrpwm: Convert to json schema
Date:   Fri,  4 Jun 2021 11:48:06 +0200
Message-Id: <162280005726.1092288.11858422401702133382.b4-ty@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210601054402.2223-1-lokeshvutla@ti.com>
References: <20210601054402.2223-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 1 Jun 2021 11:14:00 +0530, Lokesh Vutla wrote:
> This series:
> - converts tiehrpwn to DT schema format using json-schema
> - Add new compatible for AM64 SoC.
> 
> Changes since v2 (https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=489981):
> - Dropped DT changes from this series.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: pwm: pwm-tiehrpwm: Convert to json schema
      commit: 2ba4597d932b45b25bc2e6604c1dbbb08e444cb7
[2/2] dt-bindings: pwm: pwm-tiehrpwm: Add compatible string for AM64 SoC
      commit: d233504af7db9f4ddbbc4b04513d5ca657e7ae1f

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
