Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA6C35673A
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Jun 2019 12:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfFZK4l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Jun 2019 06:56:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37070 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfFZK4l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Jun 2019 06:56:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id f17so1614257wme.2
        for <linux-pwm@vger.kernel.org>; Wed, 26 Jun 2019 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=l3xGq8iHbu4VPHSEtvqfb52UstsRlMdZS5rhtavrkfk=;
        b=bSfaX/mdVSXrduJMIgmWA94aPV9L9YhlMWwT196AMyYjf0/cWJcl+BF2RHttsx8U7w
         XicxiCo7ImeGcRU5+/f6iofwm4PtC30d8vmoOpVkRzPdpjIwZ/cwNC8o8S8EeEq6JfEZ
         yPH8AjH1y/XOA5U/bnUtIT2HwZu74aD7UEfwuz/EzQ5UpsSQW8vVfhkLrLLVAXJzIMea
         T6JdT0ZTd6xEtu0TKvLb1AcEh/iHGC688urt6Z5ZkyHnyVo+GMs5upz3abd79L+/VXXS
         kYXnxZtmnjaJEv5Z/qT9kjNAFwYLwIGw1SaPDy6Ok9tf1kX4QlbCXtHVU5nZMVZCqyE9
         GFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=l3xGq8iHbu4VPHSEtvqfb52UstsRlMdZS5rhtavrkfk=;
        b=MMC+3idEKyqWCXKKiilvqQR+eirxZutzfDq5ruLmekx0F0xUBWqgh40vw1ZW5EwCaJ
         yT1E//Ha9zGqanFf1v4O/Ko2gEcHTBAW2VmGsoyL7rXEo2JUotQMGlveujk5fidUx3uP
         he4maf+lrTDcSFi0TmdV3qM1f6tqRSqGEdtn5W0VQJV1yzC+qZBFpV/ogrQMvwFigzcl
         U+cIvA9RlT1JDjTcVsBvkIYBx+lkoW4WablPmA+5pb7pld2S7lQJnstXMawYt4O8M/r/
         6Ijn6MhM933cYfH/hoKUgyo4gLZeC2OvpXngH2Ee8Of7PBjRN1gIoDgY13eD7tleHdiO
         3bdw==
X-Gm-Message-State: APjAAAWOu0xCvNRh8pnaYQxAZk5DEKYmHBc9Yoa9jklPGh59NJmO3bOF
        uZgmx7FN/w1fHqOsfWnQzW06gA==
X-Google-Smtp-Source: APXvYqyXZjo09Cb5XAit2USHVh0oUIciSblg/vIQxabQ7/vHyjIewvMDHnvJHFjO56IzAmBgbVTuzA==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr2469031wmi.0.1561546599066;
        Wed, 26 Jun 2019 03:56:39 -0700 (PDT)
Received: from dell ([2.27.35.164])
        by smtp.gmail.com with ESMTPSA id 128sm2621336wme.12.2019.06.26.03.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 03:56:38 -0700 (PDT)
Date:   Wed, 26 Jun 2019 11:56:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1] backlight: pwm_bl: convert to use SPDX identifier
Message-ID: <20190626105636.GO21119@dell>
References: <20190619135927.29745-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619135927.29745-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 19 Jun 2019, Andy Shevchenko wrote:

> Reduce size of duplicated comments by switching to use SPDX identifier.
> 
> No functional change.
> 
> While here, correct MODULE_LICENSE() string to be aligned with license text.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
