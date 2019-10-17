Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0D0FDB77F
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 21:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503533AbfJQT3O (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 15:29:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44674 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503522AbfJQT3O (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 15:29:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so3628769wrl.11
        for <linux-pwm@vger.kernel.org>; Thu, 17 Oct 2019 12:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y2Yht26P1vktZqaQqNQXULa6hC952BSjLWHUGdYiAU8=;
        b=fCVM4e+bvdog5i14IO692HIFF2qWjQ0LOWu44jjaqLNYlT57j+YcEM3ekGAQzZxz20
         3tXFppYjDQYdLxkimlZWT/gcCRiQyRg320zGG1vYFDcrK67Jq7KAEOqi626aIGH63Im+
         8Pds1sqO0H0UNx8RL3YqD6sO/ctMHvtOhdyaRg1CG5km52KKuU321lt6Quh/OP9Tqu1U
         QWHd+dOgBZtVUrFAJvcjnWoc0ybTzWsXXpklDwCUusD9+qX/2j2lVcI0GRcBE7aln3QR
         v0icYUOa2IQjV7XpwtuLPAcoX1QGU0ZzDUOK8STZwCPOFF09pCfrSKFCmSGTSSBv41lr
         iU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y2Yht26P1vktZqaQqNQXULa6hC952BSjLWHUGdYiAU8=;
        b=Sz1FQcIaQ1y3ef4xumLgqqLQyXnZ6zb9YTpglBFcXvVgpJasDfR/BuwjJHhiceVs3d
         ZCuq9lknqxo/O6NOzBi1YLQ+f+gXa0jsar+b8rpc2VLjbCPx8RT9vtTts1T2HLKu4tpk
         ysnJO2pYqs1yjeeQco/FLbsJjjBG6l+Xz/JyYTrrh8TQ/Nf/3uTbkWiA++LPyRmak11Z
         /sKGJFCZ5Jq3RCNuV9t1lpBXAW7h6PlTMJeN0qrGH2ZDJHDVU9CBoEzNtRh4EA9VffUA
         QGQZR8xz1LXpDiUoH0m6WZC4oQnNlhY0Vt9HaqUlPepEbDR/2g8B4sVCUcKHYHPq2tOo
         7VfA==
X-Gm-Message-State: APjAAAVnOd80qIH4gM3y/vn1RHxbgeJccNbX/3UlOGAO4aOoJiwo/3re
        SNkp5y0V2H5jH9CNgsnfwU8=
X-Google-Smtp-Source: APXvYqxX+snzChK31VXq4N7NBXDyDvvBCati/n7FkaOSt0E8/hS5jW4bweg0u6211P5O37rSRC5gSQ==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr4350839wru.75.1571340552062;
        Thu, 17 Oct 2019 12:29:12 -0700 (PDT)
Received: from [10.230.29.119] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k3sm3227342wrn.41.2019.10.17.12.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2019 12:29:11 -0700 (PDT)
Subject: Re: [PATCH] pwm: bcm-iproc: prevent unloading the driver module while
 in use
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20191017192218.9042-1-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b5ebfe5b-1c5a-8349-d232-d69f28024d35@gmail.com>
Date:   Thu, 17 Oct 2019 12:29:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191017192218.9042-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 10/17/2019 12:22 PM, Uwe Kleine-König wrote:
> The owner member of struct pwm_ops must be set to THIS_MODULE to
> increase the reference count of the module such that the module cannot
> be removed while its code is in use.
> 
> Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
