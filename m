Return-Path: <linux-pwm+bounces-1525-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B018562FE
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 13:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71801C21949
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Feb 2024 12:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CD112C7FB;
	Thu, 15 Feb 2024 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B9Exccb+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jfX3S0xj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B9Exccb+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jfX3S0xj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680C12C7E9;
	Thu, 15 Feb 2024 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999589; cv=none; b=dj5ogX38xY2aLQiWgyBnUO9yJsVS+GZTvNglSdXccwARZpFu1lYMBP6+JtAufnleOZTs1/IfyzHiwy3vQhd4Ea2LNCpa7rKvQHCw/XuLU7Bth1IXU+CzXFclOdxJMtGVNuDjLyMoeCMPZ52GHs3NZ2WzVLhfRDl3Dr44CAuGBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999589; c=relaxed/simple;
	bh=4XfjBj/iGsIw6j/Q8I86JTqc8S9He8yLLrpU5gF7RDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b54KVl4qUTccASPTsN1F8loMf7B0+dvmfd7yvaRA/vUb/gnToWg+8zhGG5cOcmPanfUpolfVEuLEz0iXDKkuR7ggMsSD70YdgH6iqLj2d/CkEKyRHqLkH1WO5cx3REYjKKCf3s/OMDQOikn/VnPY13yC3imHzTZdhtuCE+W67ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B9Exccb+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jfX3S0xj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B9Exccb+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jfX3S0xj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA40E1F890;
	Thu, 15 Feb 2024 12:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707999585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UZQobRP1cFDztt1lCx3NiPhhYfzN8NCrL/yy1Gel9jE=;
	b=B9Exccb+PneXCSKFo9hCAnMge4lCaTnTyfYTd7/5M0GUWOn3lnJDLFVCzoMPqDnUOJXxa7
	Ac3qgnWrqmRGbTZ4zDndQODw/t7VkR0FO5MzIn+JP/NO8GOCacoqhHQ/6toW7Jg60b4+1k
	Soas1RgGQ89iXvcAMuKqRLDcTJUnNao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707999585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UZQobRP1cFDztt1lCx3NiPhhYfzN8NCrL/yy1Gel9jE=;
	b=jfX3S0xjiJVnricRWFuQm2DM54VCIGx18E9aJ4kI+HsmRM76HiNxCOv8E0vGTsdgWg8kK4
	pmSLa1LCXKsHfABw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707999585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UZQobRP1cFDztt1lCx3NiPhhYfzN8NCrL/yy1Gel9jE=;
	b=B9Exccb+PneXCSKFo9hCAnMge4lCaTnTyfYTd7/5M0GUWOn3lnJDLFVCzoMPqDnUOJXxa7
	Ac3qgnWrqmRGbTZ4zDndQODw/t7VkR0FO5MzIn+JP/NO8GOCacoqhHQ/6toW7Jg60b4+1k
	Soas1RgGQ89iXvcAMuKqRLDcTJUnNao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707999585;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UZQobRP1cFDztt1lCx3NiPhhYfzN8NCrL/yy1Gel9jE=;
	b=jfX3S0xjiJVnricRWFuQm2DM54VCIGx18E9aJ4kI+HsmRM76HiNxCOv8E0vGTsdgWg8kK4
	pmSLa1LCXKsHfABw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 89A891346A;
	Thu, 15 Feb 2024 12:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zjFWIGEBzmUCDAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Thu, 15 Feb 2024 12:19:45 +0000
Message-ID: <61d23ae6-5233-4b36-9f59-8ea1750796c4@suse.de>
Date: Thu, 15 Feb 2024 13:19:45 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] hid/hid-picolcd: Remove struct
 backlight_ops.check_fb
Content-Language: en-US
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de, javierm@redhat.com,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
 =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
References: <20240212162645.5661-1-tzimmermann@suse.de>
 <20240212162645.5661-5-tzimmermann@suse.de> <20240215120629.GH9758@aspen.lan>
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20240215120629.GH9758@aspen.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=B9Exccb+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jfX3S0xj
X-Spamd-Result: default: False [-1.76 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 BAYES_HAM(-1.46)[91.39%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,gmail.com,gmx.de,redhat.com,lists.freedesktop.org,vger.kernel.org,linux-vserver.org];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DA40E1F890
X-Spam-Level: 
X-Spam-Score: -1.76
X-Spam-Flag: NO

Hi

Am 15.02.24 um 13:06 schrieb Daniel Thompson:
> On Mon, Feb 12, 2024 at 05:16:37PM +0100, Thomas Zimmermann wrote:
>> The driver sets struct fb_info.bl_dev to the correct backlight
>> device.
> This looks like it was copied from a different patch since you
> added code to do this as part of the patch!

Yeah, I did. I'll reword this sentence to make I more precise.

Best regards
Thomas

>
>> Thus rely on the backlight core code to match backlight
>> and framebuffer devices, and remove the extra check_fb function
>> from struct backlight_ops.
>> <snip>
>> diff --git a/drivers/hid/hid-picolcd_fb.c b/drivers/hid/hid-picolcd_fb.c
>> index d7dddd99d325e..4500f6e03d32f 100644
>> --- a/drivers/hid/hid-picolcd_fb.c
>> +++ b/drivers/hid/hid-picolcd_fb.c
>> @@ -493,6 +493,10 @@ int picolcd_init_framebuffer(struct picolcd_data *data)
>>   	info->fix = picolcdfb_fix;
>>   	info->fix.smem_len   = PICOLCDFB_SIZE*8;
>>
>> +#ifdef CONFIG_HID_PICOLCD_BACKLIGHT
>> +	info->bl_dev = data->backlight;
>> +#endif
>> +
>>   	fbdata = info->par;
>>   	spin_lock_init(&fbdata->lock);
>>   	fbdata->picolcd = data;
>
> Daniel.

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


